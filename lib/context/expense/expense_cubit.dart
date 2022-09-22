import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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

  Future<void> addExpense(
    String title,
    double amount, {
    required BudgetModel budget,
    String? desc,
    List<ExpenseCategoriesModel>? categories,
    File? receipt,
  }) async {
    try {
      ExpenseModel newExpense = await _expensesApi.createExpense(
        title,
        amount,
        desc: desc,
        receipt: receipt,
        budget: budget,
        categories: categories ?? [],
      );

      _expenseStorage.addExpense(newExpense);
      _expenses.add(newExpense);
      _key.currentState?.insertItem(_expenses.length - 1);

      logger.fine(newExpense);
    } catch (e) {
      logger.shout(e.toString());
    }
  }

  Future<void> getExpenses() async {
    try {
      List<ExpenseModel>? updatedExpenses = await _expensesApi.getExpenses();
      logger.config('Hellow from here');
      if (updatedExpenses != null) {
        logger.info('Invalidating cache for expenses');
        await _expenseStorage.deleteExpense();
        await _expenseStorage.addExpenses(updatedExpenses);
      }
      _expenses = ExpenseStorage.getExpense();
      emit(ExpenseLoadSuccess(data: _expenses));
      Future future = Future(() {});
      for (var element in _expenses) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(_expenses.indexOf(element));
              }
            },
          ),
        );
      }
    } on DioError catch (dio) {
      emit(ExpenseLoadFailed(message: dio.message));
    } catch (e) {
      emit(ExpenseLoadFailed(message: e.toString()));
    }
  }
}
