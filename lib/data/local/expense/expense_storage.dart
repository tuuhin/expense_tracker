import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/domain/models/expense/expense_model.dart';
import 'package:hive/hive.dart';

import '../../dto/expense/expense_dto.dart';

class ExpenseStorage {
  static Box<ExpenseEntity>? expenses;

  static Future<void> init() async {
    expenses = await Hive.openBox<ExpenseEntity>('expenses');
  }

  Future<void> addExpense(ExpenseModel expenseModel) async =>
      await expenses!.add(ExpenseDto.fromExpenseModel(expenseModel).toEntity());

  Future<void> addExpenses(List<ExpenseModel> expenseModels) async =>
      await expenses!.addAll(
        expenseModels.map(
          (ExpenseModel model) => ExpenseDto.fromExpenseModel(model).toEntity(),
        ),
      );

  List<ExpenseModel> getExpense() => expenses!.values
      .map((ExpenseEntity e) => ExpenseDto.fromEntity(e).toExpenseModel())
      .toList();

  Future<void> deleteExpenseCategory(ExpenseModel expenseModel) async {
    int index =
        getExpense().indexWhere((element) => element.id == expenseModel.id);
    await expenses!.deleteAt(index);
  }

  Future<void> deleteExpense() async => await expenses!.clear();
}
