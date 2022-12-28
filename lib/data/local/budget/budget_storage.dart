import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class BudgetStorage {
  static late final LazyBox<BudgetEntity>? _budget;

  static Future<void> init() async {
    _budget = await Hive.openLazyBox<BudgetEntity>('_budget');
  }

  Future<void> addBudget(BudgetEntity entity) async =>
      await _budget!.put(entity.id, entity);

  Future<void> addBudgets(List<BudgetEntity> entites) async => await _budget!
      .putAll(entites.asMap().map((key, value) => MapEntry(value.id, value)));

  Future<Iterable<BudgetEntity>> getBudget() async =>
      (await Future.wait<BudgetEntity?>(
              _budget!.keys.map((e) => _budget!.get(e))))
          .whereType<BudgetEntity>();

  Future<BudgetEntity?> getBudgetById(BudgetEntity entity) async =>
      await _budget?.get(entity.id);

  Future<void> updateBudget(BudgetEntity entity) async =>
      await _budget?.put(entity.id, entity);

  Future<void> deleteBudget(BudgetEntity entity) async =>
      await _budget!.delete(entity.id);

  Future<void> deleteAll() async => await _budget!.clear();
}
