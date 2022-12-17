import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class ExpenseStorage {
  static Box<ExpenseEntity>? expenses;

  static Future<void> init() async {
    expenses = await Hive.openBox<ExpenseEntity>('expenses');
  }

  Future<void> addExpense(ExpenseEntity entity) async =>
      await expenses!.put(entity.id, entity);

  Future<void> addExpenses(List<ExpenseEntity> enitites) async {
    await expenses!.putAll(
        enitites.asMap().map((key, entity) => MapEntry(entity.id, entity)));
    expenses!.flush();
  }

  Iterable<ExpenseEntity> getExpenses() => expenses!.values.toList().reversed;

  ExpenseEntity? getExpenseById(ExpenseEntity entity) =>
      expenses?.get(entity.id);

  Future<void> updateExpense(ExpenseEntity entity) async =>
      await expenses?.put(entity.id, entity);

  Future<void> deleteExpense(ExpenseEntity entity) async =>
      await expenses!.delete(entity.id);

  Future<void> deleteAll() async =>
      expenses!.keys.map((e) async => await expenses!.delete(e));
}
