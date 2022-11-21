import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  final List<NotificationDataModel> _data = [];

  int? _offsetFromString(String url) =>
      int.tryParse(Uri.parse(url).queryParameters["offset"] ?? '');

  Timer _limiter = Timer(const Duration(milliseconds: 1000), () {});

  int _offset = 0;

  String? _nextURL;

  NotificationBloc(this.repository) : super(const _Loading()) {
    on<FetchSome>((event, emit) async {
      try {
        NotificationModel holder = await repository.getNotification();
        _nextURL = holder.next;
        if (holder.next != null) {
          _offset = _offsetFromString(holder.next!) ?? 1;
        }
        emit(NotificationState.data(_data..addAll(holder.data)));
        for (final NotificationDataModel notification in _data) {
          await Future.delayed(const Duration(milliseconds: 50),
              () => _key.currentState?.insertItem(_data.indexOf(notification)));
        }
      } catch (err, stk) {
        debugPrintStack(stackTrace: stk);
        emit(NotificationState.error(err.toString()));
      }
    });

    on<FetchMore>((event, emit) async {
      try {
        if (_nextURL == null) {
          emit(NotificationState.end(_data, "End of list"));
          return;
        }
        if (_limiter.isActive) return;
        _limiter = Timer(const Duration(seconds: 2), () {});

        emit(NotificationState.loadmore(_data));
        NotificationModel holder =
            await repository.getMoreNotification(offset: _offset, limit: 5);
        _nextURL = holder.next;
        if (holder.next != null) {
          _offset = _offsetFromString(holder.next!) ?? 1;
        }
        emit(NotificationState.data(_data..addAll(holder.data)));
        for (final NotificationDataModel notification in holder.data) {
          await Future.delayed(const Duration(milliseconds: 50),
              () => _key.currentState?.insertItem(_data.indexOf(notification)));
        }
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        emit(NotificationState.errorLoadMore(_data, e.toString()));
      }
    });
  }

  void fetchMore() => add(const FetchMore());

  void init() =>
      _data.isEmpty ? add(const FetchSome()) : add(const FetchMore());
}
