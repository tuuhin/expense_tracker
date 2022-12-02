import 'package:bloc/bloc.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/goals_repository.dart';

part 'goals_event.dart';
part 'goals_state.dart';
part 'goals_bloc.freezed.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GoalsRepository _repo;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  GoalsBloc(this._repo) : super(_Loading()) {
    on<_GetData>((event, emit) async {
      try {
        List<GoalsModel> goals = await _repo.getGoals();

        emit(GoalsState.success(data: goals, message: "Successfull"));
        for (int i = 0; i < goals.length; i++) {
          _key.currentState?.insertItem(i);
        }
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        emit(GoalsState.error(message: e.toString()));
      }
    });
    on<_Refresh>((event, emit) {});
  }

  void fetchGoals() => add(_GetData());
}
