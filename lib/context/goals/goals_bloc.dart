import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../context.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

part 'goals_event.dart';
part 'goals_state.dart';
part 'goals_bloc.freezed.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GoalsRepository _repo;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  final UiEventCubit<GoalsModel> _uiEvent = UiEventCubit<GoalsModel>();

  UiEventCubit<GoalsModel> get uiEvent => _uiEvent;
  GlobalKey<SliverAnimatedListState> get key => _key;

  GoalsBloc(this._repo) : super(_Loading()) {
    on<_GetData>((event, emit) async {
      Resource<List<GoalsModel>> goals = await _repo.getGoals();

      goals.whenOrNull(
        data: (data, message) {
          if (data.isEmpty) {
            emit(GoalsState.noData(message: "No data"));
            return;
          }
          emit(GoalsState.data(data: data, message: message));
        },
        error: (err, errorMessage, data) {
          if (data != null && data.isNotEmpty) {
            emit(GoalsState.errorWithData(
                error: err, message: errorMessage, data: data));
            return;
          }
          emit(GoalsState.error(error: err, message: errorMessage));
        },
      );
    });
    on<_Refresh>((event, emit) {
      emit(GoalsState.loading());
      add(_GetData());
    });

    on<_AddGoal>((event, emit) async {
      Resource<GoalsModel?> createGoal = await _repo.addGoal(event.goal);

      createGoal.whenOrNull(
        data: (data, message) {
          if (state is! _Data && data != null) {
            _uiEvent.showDialog(
              "Refresh and try again ",
              content:
                  "The goal titled ${event.goal.title} created. Refresh to see reuslts",
            );
            return;
          }

          List<GoalsModel> newSet = (state as _$_Data).data.toList()
            ..add(data!);

          emit(GoalsState.data(data: newSet, message: message));

          key.currentState?.insertItem(0);

          _uiEvent.showSnackBar("Added new goal ${data.title}");
        },
        error: (err, errorMessage, data) => _uiEvent.showDialog(
            "Cannot add goal ${event.goal.title}. ",
            content: "Error Occured :$errorMessage "),
      );
    });

    on<_DeleteGoal>((event, emit) async {
      Resource<void> delete = await _repo.removeGoal(event.goal);
      delete.whenOrNull(
        data: (data, message) {
          if (state is! _Data) {
            _uiEvent.showSnackBar(
                "Your goal has been removed please refresh to see results");
            return;
          }
          int index = (state as _Data).data.indexOf(event.goal);
          _key.currentState?.removeItem(
            index,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: event.widget),
          );

          List<GoalsModel> newSet = (state as _Data).data.toList()
            ..removeAt(index);

          emit(GoalsState.data(data: newSet, message: message));

          _uiEvent.showSnackBar("Removed goal ${event.goal.title}");
          return;
        },
        error: (err, errorMessage, data) => _uiEvent.showSnackBar(
            "Cannot delete goal ${event.goal.title}. Error Occured :$errorMessage"),
      );
    });
    on<_UpdateGoal>((event, emit) async {
      Resource<GoalsModel?> update = await _repo.updateGoal(event.goal);
      update.whenOrNull(
        data: (data, message) {},
        error: (err, errorMessage, data) {},
      );
    });
  }

  Future<void> fetchGoals() async => add(_GetData());

  Future<void> refreshGoals() async => add(_Refresh());

  Future<void> createGoal(CreateGoalModel goal) async => add(_AddGoal(goal));

  Future<void> removeGoal(GoalsModel goal, {required Widget widget}) async =>
      add(_DeleteGoal(goal, widget: widget));

  Future<void> updateGoal(GoalsModel goal) async => add(_UpdateGoal(goal));
}
