import 'package:expense_tracker/domain/models/models.dart';
import 'dart:io';

abstract class ExpenseRepostiory {
  Future<bool> createExpense(String title, double amount,
      {String? desc, List<ExpenseCategoriesModel>? categories, File? receipt});

  Future<bool> createCategory(String title, {String? desc});

  Future<bool> deleteCategory(int id);

  Future<bool> deleteExpense(int id);

  Future<List<ExpenseCategoriesModel?>> getCategories();

  Future<IncomeModel?> getExpenses();
}
