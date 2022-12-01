part of 'goals_bloc.dart';

@freezed
class GoalsEvent with _$GoalsEvent {
  factory GoalsEvent.getGoals() = _GetData;

  factory GoalsEvent.addGoal() = _AddGoal;
  factory GoalsEvent.deleteGoal() = _DeleteGoal;
}
