import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/goals_repository.dart';

part 'goals_event.dart';
part 'goals_state.dart';
part 'goals_bloc.freezed.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GoalsRepository _repo;

  final List<GoalsModel> _goals = [];

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  GoalsBloc(this._repo) : super(_Loading()) {
    on<_GetData>((event, emit) async {
      try {
        List<GoalsModel> goals = await _repo.getGoals();
        _goals.addAll(goals);
        emit(GoalsState.success(data: _goals, message: "Successfull"));
      } catch (e) {
        emit(GoalsState.error(message: e.toString()));
      } finally {
        for (int i = 0; i < _goals.length; i++) {
          _key.currentState?.insertItem(i);
        }
      }
    });
  }

  void fetchGoals() => add(_GetData());
}
