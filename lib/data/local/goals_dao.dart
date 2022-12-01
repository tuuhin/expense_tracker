import 'package:hive/hive.dart';

import '../entity/entity.dart';

class GoalsDao {
  static Box<GoalsEntity>? _goals;

  static Future init() async {
    _goals = await Hive.openBox<GoalsEntity>('goals');
  }

  Future<void> addGoal(GoalsEntity goal) async => await _goals?.add(goal);

  Future<void> addGoalsList(List<GoalsEntity> goals) async =>
      await _goals!.addAll(goals);

  List<GoalsEntity> getGoals() => _goals!.values.toList();

  Future<void> deleteGoal(GoalsEntity goal) async => _goals!.deleteAt(goal.id);

  Future<void> deleteAll() async => await _goals!.clear();
}
