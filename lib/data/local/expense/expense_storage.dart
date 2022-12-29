import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class ExpenseStorage {
  static LazyBox<ExpenseEntity>? expenses;

  static Future<void> init() async {
    expenses = await Hive.openLazyBox<ExpenseEntity>('expenses');
  }

  Future<void> addExpense(ExpenseEntity entity) async =>
      await expenses!.put(entity.id, entity);

  Future<void> addExpenses(List<ExpenseEntity> enitites) async =>
      await expenses!.putAll(
          enitites.asMap().map((key, entity) => MapEntry(entity.id, entity)));

  Future<Iterable<ExpenseEntity>> getExpenses() async =>
      (await Future.wait<ExpenseEntity?>(
              expenses!.keys.map((e) => expenses!.get(e))))
          .whereType<ExpenseEntity>();

  Future<ExpenseEntity?> getExpenseById(ExpenseEntity entity) async =>
      await expenses?.get(entity.id);

  Future<void> updateExpense(ExpenseEntity entity) async =>
      await expenses?.put(entity.id, entity);

  Future<void> deleteExpense(ExpenseEntity entity) async =>
      await expenses!.delete(entity.id);

  Future<void> deleteAll() async => expenses!.clear();
}
