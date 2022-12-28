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
      emit(GoalsState.loading());
      Resource<List<GoalsModel>> goals = await _repo.getGoals();

      goals.whenOrNull(
        data: (data, message) => (data.isEmpty)
            ? emit(GoalsState.noData(message: "No data found"))
            : emit(GoalsState.data(data: data, message: message)),
        error: (err, errorMessage, data) => (data != null && data.isNotEmpty)
            ? emit(GoalsState.errorWithData(
                error: err, message: errorMessage, data: data))
            : emit(GoalsState.error(error: err, message: errorMessage)),
      );
    });
    on<_Refresh>((event, emit) => add(_GetData()));

    on<_AddGoal>((event, emit) async {
      Resource<GoalsModel?> createGoal = await _repo.addGoal(event.goal);

      createGoal.whenOrNull(
        data: (data, message) => state.maybeWhen(
          orElse: () => _uiEvent.showDialog("Refresh and try again ",
              content:
                  "The goal titled ${event.goal.title} created. Refresh to see reuslts"),
          noData: (message) => data != null
              ? emit(GoalsState.data(data: [data], message: message))
              : null,
          data: (prevData, _) {
            if (data == null) return;
            List<GoalsModel> newSet = prevData.toList()..add(data);
            emit(GoalsState.data(data: newSet));
            key.currentState?.insertItem(newSet.length - 1);
            _uiEvent.showSnackBar("Added new goal ${data.title}");
          },
        ),
        error: (err, errorMessage, data) => _uiEvent.showDialog(
            "Cannot add goal ${event.goal.title}.",
            content: "Error Occured :$errorMessage"),
      );
    });

    on<_DeleteGoal>((event, emit) async {
      Resource<void> response = await _repo.removeGoal(event.goal);

      response.whenOrNull(
        data: (_, message) => state.maybeWhen(
          orElse: () => _uiEvent.showDialog("Refresh and try again ",
              content:
                  "The goal titled ${event.goal.title} removed. Refresh to see reuslts"),
          data: (prevData, _) {
            int index = prevData.indexOf(event.goal);
            _key.currentState?.removeItem(
              index,
              (context, animation) =>
                  SizeTransition(sizeFactor: animation, child: event.widget),
            );
            List<GoalsModel> newData = prevData.toList()..remove(event.goal);

            if (newData.isEmpty) {
              emit(GoalsState.noData(message: message ?? "No budgets found"));
              return;
            }
            emit(GoalsState.data(data: newData, message: message));

            _uiEvent.showSnackBar(
                "Your budget titled ${event.goal.title} has been deleted");
          },
        ),
        error: (err, errorMessage, _) => _uiEvent.showDialog(
            "Failed to delete budget titled : ${event.goal.title}",
            content: errorMessage),
      );
    });
    on<_UpdateGoal>((event, emit) async {
      Resource<GoalsModel?> update = await _repo.updateGoal(event.goal);

      update.whenOrNull(
        data: (data, message) => state.maybeWhen(
          orElse: () => _uiEvent.showDialog("Refresh and try again ",
              content:
                  "The goal titled ${event.goal.title} updated. Refresh to see reuslts"),
          data: (prevData, _) {
            if (data == null) return;
            List<GoalsModel> newSet = prevData.toList()
              ..removeWhere((item) => item.id == event.goal.id)
              ..add(data);

            emit(GoalsState.data(data: newSet));
            _uiEvent.showSnackBar("Goal: ${data.title} has been updated.");
          },
        ),
        error: (err, errorMessage, data) =>
            _uiEvent.showSnackBar("Cannot update goal ${event.goal.title}"),
      );
    });
  }

  Future<void> fetchGoals() async => add(_GetData());

  Future<void> refreshGoals() async => add(_Refresh());

  void createGoal(CreateGoalModel goal) => add(_AddGoal(goal));

  Future<void> removeGoal(GoalsModel goal, {required Widget widget}) async =>
      add(_DeleteGoal(goal, widget: widget));

  void updateGoal(GoalsModel goal) => add(_UpdateGoal(goal));
}
