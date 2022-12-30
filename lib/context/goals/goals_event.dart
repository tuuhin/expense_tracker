part of 'goals_bloc.dart';

@freezed
class GoalsEvent with _$GoalsEvent {
  factory GoalsEvent.getGoals() = _GetData;

  factory GoalsEvent.refresh() = _Refresh;

  factory GoalsEvent.clear() = _Clear;

  factory GoalsEvent.addGoal(CreateGoalModel goal) = _AddGoal;

  factory GoalsEvent.deleteGoal(GoalsModel goal, {required Widget widget}) =
      _DeleteGoal;

  factory GoalsEvent.updateGoal(GoalsModel goal) = _UpdateGoal;
}
