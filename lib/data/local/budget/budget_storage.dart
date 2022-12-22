import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class BudgetStorage {
  static Box<BudgetEntity>? budget;

  static Future<void> init() async {
    budget = await Hive.openBox<BudgetEntity>('budget');
  }

  Future<void> addBudget(BudgetEntity entity) async =>
      await budget!.put(entity.id, entity);

  Future<void> addBudgets(List<BudgetEntity> entites) async => await budget!
      .putAll(entites.asMap().map((key, value) => MapEntry(value.id, value)));

  Iterable<BudgetEntity> getBudget() => budget!.values.toList()
    ..sort((e1, e2) => e2.issedAt.compareTo(e1.issedAt));

  BudgetEntity? getBudgetById(BudgetEntity entity) => budget?.get(entity.id);

  Future<void> updateBudget(BudgetEntity entity) async =>
      await budget?.put(entity.id, entity);

  Future<void> deleteBudget(BudgetEntity entity) async =>
      await budget!.delete(entity.id);

  Future<void> deleteAllBudget() async => await budget!.clear();
}
