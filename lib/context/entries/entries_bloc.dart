import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'entries_event.dart';
part 'entries_state.dart';
part 'entries_bloc.freezed.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  final EntriesRepository _repository;
  final List<EntriesDataModel> _entries = [];

  int get entriesCount => _entries.length;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  int? _offsetFromString(String url) =>
      int.tryParse(Uri.parse(url).queryParameters["offset"] ?? '');

  Timer _limiter = Timer(const Duration(milliseconds: 2000), () {});

  int _offset = 0;

  String? _nextURL;

  EntriesBloc(this._repository) : super(_Loading()) {
    on<_FetchSome>((event, emit) async {
      Resource<EntriesModel> entries = await _repository.getEntries();

      entries.whenOrNull(
        data: (data, message) {
          _nextURL = data.nextURL;
          if (_nextURL != null) {
            _offset = _offsetFromString(_nextURL!) ?? 1;
          }
          data.entries.isEmpty
              ? emit(EntriesState.noData(message: "No data found"))
              : emit(EntriesState.data(data: _entries..addAll(data.entries)));
        },
        error: (err, errorMessage, data) =>
            emit(EntriesState.error(error: errorMessage)),
      );
    });

    on<_FetchMore>((event, emit) async {
      if (state is _Loading || state is _Error) return;
      if (_nextURL == null) {
        emit(EntriesState.end(data: _entries, message: "END OF THE LIST"));
        return;
      }
      if (_limiter.isActive) return;
      _limiter = Timer(const Duration(milliseconds: 2000), () {});
      emit(EntriesState.loadMore(data: _entries));

      Resource<EntriesModel> entries =
          await _repository.getMoreEntries(offset: _offset, limit: 5);

      entries.whenOrNull(
        data: (data, message) async {
          _nextURL = data.nextURL;
          if (_nextURL != null) {
            _offset = _offsetFromString(_nextURL!) ?? 1;
          }
          emit(EntriesState.data(data: _entries..addAll(data.entries)));

          for (final EntriesDataModel entry in data.entries) {
            await Future.delayed(
              const Duration(milliseconds: 100),
              () => _key.currentState?.insertItem(_entries.indexOf(entry)),
            );
          }
        },
        error: (err, errorMessage, data) => emit(
            EntriesState.errorLoadMore(data: _entries, error: errorMessage)),
      );
    });

    on<_Referesh>((event, emit) {
      _entries.clear();
      emit(EntriesState.loading());
      add(_FetchSome());
    });

    on<_Clear>((event, emit) {
      _entries.clear();
      emit(EntriesState.loading());
    });
  }

  Future<void> refresh() async => add(_Referesh());

  void fetchMore() => add(_FetchMore());

  Future<void> clear() async => add(_Clear());

  void init() => _entries.isEmpty ? add(_FetchSome()) : add(_FetchMore());
}
