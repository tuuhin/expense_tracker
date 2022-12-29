import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../dto/dto.dart';
import '../entity/entity.dart';
import '../local/storage.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class ExpenseRepoImpl implements ExpenseRespository {
  final ExpensesApi api;

  final CategoriesStorage categoryStore;
  final ExpenseStorage expenseStore;

  ExpenseRepoImpl({
    required this.api,
    required this.categoryStore,
    required this.expenseStore,
  });

  @override
  Future<Resource<List<ExpenseCategoriesModel>>> getCategories() async {
    try {
      Iterable<ExpenseCategoryDto> categories = await api.getCategories();
      await categoryStore.deleteAllCategory();
      await categoryStore
          .addExpenseCategories(categories.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: (await categoryStore.getCategories())
            .map((e) => ExpenseCategoryDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: (await categoryStore.getCategories())
            .map((e) => ExpenseCategoryDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<List<ExpenseCategoriesModel>> cachedCategories() async =>
      (await categoryStore.getCategories())
          .map((e) => ExpenseCategoryDto.fromEntity(e).toModel())
          .toList();

  @override
  Future<Resource<ExpenseCategoriesModel?>> createCategory(
      CreateCategoryModel category) async {
    try {
      ExpenseCategoryDto dto =
          await api.createCategory(CreateCategoryDto.fromModel(category));
      await categoryStore.addExpenseCategory(dto.toEntity());
      CategoryEntity? entity =
          await categoryStore.getCategoryById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);

      return Resource.data(
          data: ExpenseCategoryDto.fromEntity(entity).toModel());
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<ExpenseModel?>> createExpense(
      CreateExpenseModel expense) async {
    try {
      ExpenseDto dto =
          await api.createExpense(CreateExpenseDto.fromModel(expense));
      await expenseStore.addExpense(dto.toEntity());
      ExpenseEntity? entity = await expenseStore.getExpenseById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);

      return Resource.data(data: ExpenseDto.fromEntity(entity).toModel());
    } on DioError catch (e) {
      logger.fine(e.response?.data);
      return Resource.error(err: e, errorMessage: "Dioerror");
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Error");
    }
  }

  @override
  Future<Resource<void>> deleteCategory(ExpenseCategoriesModel category) async {
    try {
      await api.deleteCategory(ExpenseCategoryDto.fromModel(category));
      await categoryStore
          .deleteCategory(ExpenseCategoryDto.fromModel(category).toEntity());

      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<void>> deleteExpense(ExpenseModel expense) async {
    try {
      await api.deleteExpense(ExpenseDto.fromModel(expense));
      await expenseStore
          .deleteExpense(ExpenseDto.fromModel(expense).toEntity());
      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<List<ExpenseModel>>> getExpense() async {
    try {
      Iterable<ExpenseDto> expenses = await api.getExpenses();
      await expenseStore.deleteAll();
      await expenseStore
          .addExpenses(expenses.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: (await expenseStore.getExpenses())
            .map((e) => ExpenseDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: (await expenseStore.getExpenses())
            .map((e) => ExpenseDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<ExpenseModel?>> updateExpense(
      UpdateExpenseModel expense) async {
    try {
      ExpenseDto dto =
          await api.updateExpense(UpdateExpenseDto.fromModel(expense));
      await expenseStore.updateExpense(dto.toEntity());
      ExpenseEntity? entity = await expenseStore.getExpenseById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);
      return Resource.data(data: ExpenseDto.fromEntity(entity).toModel());
    } on DioError catch (e) {
      logger.fine(e.response?.data);
      return Resource.error(err: e, errorMessage: "Dioerror");
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Error");
    }
  }
}
