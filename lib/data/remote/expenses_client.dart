import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/domain/repositories/repositories.dart';
import 'package:expense_tracker/data/dto/dto.dart';

class ExpensesClient extends BaseClient implements ExpenseRepostiory {
  @override
  Future<ExpenseCategoriesModel> createCategory(String title,
      {String? desc}) async {
    Response _resp =
        await dio.post('/categories', data: {'title': title, 'desc': desc});
    return ExpenseCategoryDto.fromJson(_resp.data).toExpenseCategoryModel();
  }

  @override
  Future<ExpenseModel> createExpense(
    String title,
    double amount, {
    String? desc,
    List<ExpenseCategoriesModel>? categories,
    File? receipt,
  }) async {
    Response _resp = await dio.post(
      '/expense',
      data: FormData.fromMap({
        'title': title,
        'amount': amount,
        'desc': desc,
        'categories': categories!
            .map((e) => ExpenseCategoryDto.fromExpenseCategoryModel(e).toJson())
            .toList(),
        'receipt': receipt != null
            ? await MultipartFile.fromFile(receipt.path, filename: receipt.path)
            : null,
      }),
    );
    return ExpenseDto.fromJson(_resp.data).toExpenseModel();
  }

  @override
  Future deleteCategory(ExpenseCategoriesModel expenseCategoriesModel) async =>
      await dio.delete('/categories/${expenseCategoriesModel.id}');

  @override
  Future deleteExpense(ExpenseModel expenseModel) async =>
      await dio.delete('/expenses/${expenseModel.id}');

  @override
  Future<List<ExpenseCategoriesModel>?> getCategories() async {
    Response _response = await dio.get('/categories');
    List categories = _response.data as List;
    return categories
        .map((json) =>
            ExpenseCategoryDto.fromJson(json).toExpenseCategoryModel())
        .toList();
  }

  @override
  Future<List<ExpenseModel>?> getExpenses() async {
    Response _response = await dio.get('/expenses');
    List expenses = _response.data as List;
    return expenses
        .map((json) => ExpenseDto.fromJson(json).toExpenseModel())
        .toList();
  }
}
