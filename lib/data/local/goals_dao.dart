import 'package:hive/hive.dart';

import '../entity/entity.dart';

class GoalsDao {
  static late final LazyBox<GoalsEntity>? _goals;

  static Future init() async {
    _goals = await Hive.openLazyBox<GoalsEntity>('goals');
  }

  Future<void> addGoal(GoalsEntity goal) async =>
      await _goals!.put(goal.id, goal);

  Future<void> addGoals(List<GoalsEntity> goals) async => await _goals!
      .putAll(goals.asMap().map((key, goal) => MapEntry(goal.id, goal)));

  Future<Iterable<GoalsEntity>> getGoals() async =>
      (await Future.wait<GoalsEntity?>(_goals!.keys.map((e) => _goals!.get(e))))
          .whereType<GoalsEntity>();

  Future<void> updateGoal(GoalsEntity goal) async =>
      await _goals!.put(goal.id, goal);

  Future<GoalsEntity?> getGoalById(GoalsEntity goal) async =>
      await _goals!.get(goal.id);

  Future<void> deleteGoal(GoalsEntity goal) async =>
      await _goals!.delete(goal.id);

  Future<void> deleteAll() async => await _goals!.clear();
}
