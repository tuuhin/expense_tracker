import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  final List<NotificationDataModel> _data = [];

  int get itemCount => _data.length;

  int? _offsetFromString(String url) =>
      int.tryParse(Uri.parse(url).queryParameters["offset"] ?? '');

  Timer _limiter = Timer(const Duration(milliseconds: 1000), () {});

  int _offset = 0;

  String? _nextURL;

  NotificationBloc(this._repository) : super(_Loading()) {
    on<_FetchSome>((event, emit) async {
      Resource<NotificationModel> entries = await _repository.getNotification();

      entries.whenOrNull(
        data: (data, message) async {
          _nextURL = data.next;
          if (_nextURL != null) {
            _offset = _offsetFromString(_nextURL!) ?? 1;
          }
          (data.data.isEmpty)
              ? emit(NotificationState.noData(message: "No data found"))
              : emit(NotificationState.data(data: _data..addAll(data.data)));
        },
        error: (err, errorMessage, data) =>
            emit(NotificationState.error(err: err, message: errorMessage)),
      );
    });

    on<_FetchMore>((event, emit) async {
      if (state is _Loading || state is _Error) return;

      if (_nextURL == null) {
        emit(NotificationState.end(data: _data, message: "END OF THE LIST"));
        return;
      }
      if (_limiter.isActive) return;
      _limiter = Timer(const Duration(milliseconds: 2000), () {});
      emit(NotificationState.loadmore(data: _data));

      Resource<NotificationModel> notifications =
          await _repository.getMoreNotification(offset: _offset);

      notifications.whenOrNull(
        data: (data, message) async {
          _nextURL = data.next;
          if (_nextURL != null) {
            _offset = _offsetFromString(_nextURL!) ?? 1;
          }
          emit(NotificationState.data(data: _data..addAll(data.data)));

          for (final NotificationDataModel notification in data.data) {
            await Future.delayed(
              const Duration(milliseconds: 100),
              () => _key.currentState?.insertItem(
                _data.indexOf(notification),
              ),
            );
          }
        },
        error: (err, errorMessage, data) => emit(
            NotificationState.errorLoadMore(
                err: err, data: _data, message: errorMessage)),
      );
    });

    on<_Refresh>((event, emit) {
      add(_Clear());
      emit(NotificationState.loading());
      add(_FetchSome());
    });

    on<_Clear>((event, emit) => _data.clear());
  }
  void fetchMore() => add(_FetchMore());

  Future<void> refresh() async => add(_Refresh());

  void init() => _data.isEmpty ? add(_FetchSome()) : add(_FetchMore());

  Future<void> clear() async => add(_Clear());
}
