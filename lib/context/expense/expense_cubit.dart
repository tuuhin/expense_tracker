import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/local/expense/expense_storage.dart';
import 'package:expense_tracker/data/remote/expenses_api.dart';
import 'package:expense_tracker/domain/models/expense/expense_model.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpensesLoading());

  final ExpensesApi _expensesApi = ExpensesApi();

  static final ExpenseStorage _expenseStorage = ExpenseStorage();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  List<ExpenseModel> _expenses = _expenseStorage.getExpense();

  List<ExpenseModel> get expenses => _expenses;

  GlobalKey<AnimatedListState> get key => _key;

  Future<void> getExpenses() async {
    try {
      List<ExpenseModel>? modelsFromServer = await _expensesApi.getExpenses();
      logger.config('Hellow from here');
      if (modelsFromServer != null) {
        logger.info('Invalidating cache for expenses');
        await _expenseStorage.deleteExpense();
        await _expenseStorage.addExpenses(modelsFromServer);
      }
      _expenses = _expenseStorage.getExpense();
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
