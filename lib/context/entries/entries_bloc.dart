import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

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

  Timer _limiter = Timer(const Duration(milliseconds: 1000), () {});

  int _offset = 0;

  String? _nextURL;

  EntriesBloc(this._repository) : super(const _Loading()) {
    on<_FetchSome>((event, emit) async {
      try {
        EntriesModel holder = await _repository.getEntries();
        _nextURL = holder.nextURL;
        if (holder.nextURL != null) {
          _offset = _offsetFromString(holder.nextURL!) ?? 1;
        }
        emit(EntriesState.data(_entries..addAll(holder.entries)));
        for (int i = 0; i < _entries.length; i++) {
          await Future.delayed(const Duration(milliseconds: 50),
              () => _key.currentState?.insertItem(0));
        }
      } catch (err, stk) {
        debugPrintStack(stackTrace: stk);
        emit(EntriesState.error(err.toString()));
      }
    });

    on<_FetchMore>((event, emit) async {
      try {
        if (_nextURL == null) {
          emit(EntriesState.end(_entries, "End of list"));
          return;
        }
        if (_limiter.isActive) return;
        _limiter = Timer(const Duration(seconds: 2), () {});

        emit(EntriesState.loadMore(_entries));
        EntriesModel holder =
            await _repository.getMoreEntries(offset: _offset, limit: 5);
        _nextURL = holder.nextURL;
        if (holder.nextURL != null) {
          _offset = _offsetFromString(holder.nextURL!) ?? 1;
        }
        emit(EntriesState.data(_entries..addAll(holder.entries)));
        for (int i = 0; i < _entries.length; i++) {
          await Future.delayed(const Duration(milliseconds: 50),
              () => _key.currentState?.insertItem(0));
        }
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        emit(EntriesState.errorLoadMore(_entries, e.toString()));
      }
    });

    on<_Clear>((event, emit) {
      _entries.clear();
      emit(const EntriesState.loading());
    });
  }

  void clear() => add(const _Clear());

  void fetchMore() => add(const _FetchMore());

  void init() =>
      _entries.isEmpty ? add(const _FetchSome()) : add(const _FetchMore());
}
