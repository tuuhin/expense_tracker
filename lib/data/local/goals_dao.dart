import 'package:hive/hive.dart';

import '../entity/entity.dart';

class GoalsDao {
  static Box<GoalsEntity>? _goals;

  static Future init() async {
    _goals = await Hive.openBox<GoalsEntity>('goals');
  }

  Future<void> addGoal(GoalsEntity goal) async =>
      await _goals!.put(goal.id, goal);

  Future<void> addGoals(List<GoalsEntity> goals) async => await _goals!
      .putAll(goals.asMap().map((key, goal) => MapEntry(goal.id, goal)));

  Iterable<GoalsEntity> getGoals() => _goals!.values;

  Future<void> updateGoal(GoalsEntity goal) async =>
      await _goals!.put(goal.id, goal);

  GoalsEntity? getGoalById(GoalsEntity goal) => _goals!.get(goal.id);

  Future<void> deleteGoal(GoalsEntity goal) async => _goals!.delete(goal.id);

  Future<void> deleteAll() async => await _goals!.clear();
}
