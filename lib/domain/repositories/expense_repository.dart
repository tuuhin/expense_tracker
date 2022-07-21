import 'package:expense_tracker/domain/models/models.dart';
import 'dart:io';

abstract class ExpenseRepostiory {
  Future<ExpenseModel> createExpense(String title, double amount,
      {String? desc, List<ExpenseCategoriesModel>? categories, File? receipt});

  Future<ExpenseCategoriesModel> createCategory(String title, {String? desc});

  Future deleteCategory(ExpenseCategoriesModel expenseCategoriesModel);

  Future deleteExpense(ExpenseModel expenseModel);

  Future<List<ExpenseCategoriesModel>?> getCategories();

  Future<List<ExpenseModel>?> getExpenses();
}
