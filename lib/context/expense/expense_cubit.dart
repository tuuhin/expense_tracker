import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';

import '../../data/local/expense/expense_storage.dart';
import '../../data/remote/remote.dart';
import '../../domain/models/models.dart';
import '../../main.dart';
import '../context.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpensesLoading());

  final ExpensesApi _expensesApi = ExpensesApi();
  final ExpenseCategoryNotifier _incomeSourceNotifier =
      ExpenseCategoryNotifier();

  final ExpenseStorage _expenseStorage = ExpenseStorage();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  List<ExpenseModel> _expenses = ExpenseStorage.getExpense();

  ExpenseCategoryNotifier get notifier => _incomeSourceNotifier;

  List<ExpenseModel> get expenses => _expenses;

  GlobalKey<AnimatedListState> get key => _key;

  Future<Resource<ExpenseModel>> addExpense(
    String title,
    double amount, {
    required BudgetModel budget,
    String? desc,
    List<ExpenseCategoriesModel>? categories,
    File? receipt,
  }) async {
    try {
      ExpenseModel newExpense = await _expensesApi.createExpense(title, amount,
          desc: desc,
          receipt: receipt,
          budget: budget,
          categories: categories ?? []);

      _expenseStorage.addExpense(newExpense);
      _expenses.add(newExpense);
      _key.currentState?.insertItem(0);
      return Resource.data(data: newExpense, message: "New Expense Added");
    } on Dio catch (dio) {
      return Resource.error(err: dio, errorMessage: "DIO ERROR OCCURED");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "UNKNOWN ERROR OCCURED");
    }
  }

  Future<void> getExpenses() async {
    try {
      List<ExpenseModel>? updatedExpenses = await _expensesApi.getExpenses();
      logger.config('got updated expense ');
      if (updatedExpenses != null) {
        logger.info('Invalidating cache for expenses');
        await _expenseStorage.deleteExpense();
        await _expenseStorage.addExpenses(updatedExpenses);
      }
      _expenses = ExpenseStorage.getExpense();
      emit(ExpenseLoadSuccess(data: _expenses));

      for (final ExpenseModel exp in _expenses) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => _key.currentState?.insertItem(_expenses.indexOf(exp)),
        );
      }
    } on DioError catch (dio) {
      emit(
        ExpenseLoadFailed(
            data: _expenses,
            errMessage: dio.response?.statusMessage ?? "DIO RELATED ERROR"),
      );
    } catch (e) {
      emit(
        ExpenseLoadFailed(data: _expenses, errMessage: "UNKNOWN ERROR"),
      );
    }
  }
}
