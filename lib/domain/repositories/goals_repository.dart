import '../models/models.dart';

abstract class GoalsRepository {
  Future<List<GoalsModel>> getGoals();
  Future<GoalsModel> addGoal(GoalsModel goal);

  Future<void> removeGoal(GoalsModel goal);
}
