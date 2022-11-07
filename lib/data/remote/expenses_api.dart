import 'dart:io';
import 'package:dio/dio.dart';

import './remote.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../dto/dto.dart';

class ExpensesApi extends ResourceClient implements ExpenseRepostiory {
  @override
  Future<ExpenseCategoriesModel> createCategory(String title,
      {String? desc}) async {
    final Response response = await dio.post(
      '/categories',
      data: {'title': title, 'desc': desc},
    );
    return ExpenseCategoryDto.fromJson(response.data).toExpenseCategoryModel();
  }

  @override
  Future<ExpenseModel> createExpense(
    String title,
    double amount, {
    required BudgetModel budget,
    String? desc,
    required List<ExpenseCategoriesModel> categories,
    File? receipt,
  }) async {
    Response response = await dio.post(
      '/expenses',
      data: FormData.fromMap(
        {
          'title': title,
          'amount': amount,
          'desc': desc,
          'budget': BudgetDto.fromModel(budget).id,
          'categories': categories
              .map<int>((ExpenseCategoriesModel e) =>
                  ExpenseCategoryDto.fromExpenseCategoryModel(e).id)
              .toList(),
          'receipt': receipt != null
              ? await MultipartFile.fromFile(receipt.path,
                  filename: receipt.path)
              : null
        },
      ),
    );
    return ExpenseDto.fromJson(response.data).toExpenseModel();
  }

  @override
  Future deleteCategory(ExpenseCategoriesModel expenseCategoriesModel) async =>
      await dio.delete('/categories/${expenseCategoriesModel.id}');

  @override
  Future deleteExpense(ExpenseModel expenseModel) async =>
      await dio.delete('/expenses/${expenseModel.id}');

  @override
  Future<List<ExpenseCategoriesModel>?> getCategories() async {
    Response response = await dio.get('/categories');
    List categories = response.data as List;
    return categories
        .map((json) =>
            ExpenseCategoryDto.fromJson(json).toExpenseCategoryModel())
        .toList();
  }

  @override
  Future<List<ExpenseModel>?> getExpenses() async {
    Response response = await dio.get('/expenses');
    List expenses = response.data as List;
    return expenses
        .map((json) => ExpenseDto.fromJson(json).toExpenseModel())
        .toList();
  }
}