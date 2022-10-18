import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/local/budget/budget_storage.dart';
import 'package:expense_tracker/data/remote/budget_api.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetLoad());

  final BudgetStorage _storage = BudgetStorage();

  final BudgetApi _api = BudgetApi();
  final GlobalKey<AnimatedListState> _listState =
      GlobalKey<AnimatedListState>();

  List<BudgetModel> _budgets = BudgetStorage.getBudget();

  List<BudgetModel> get budgets => _budgets;

  GlobalKey<AnimatedListState> get key => _listState;

  Future<Resource<BudgetModel?>> createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc}) async {
    try {
      BudgetModel newBudget = await _api.createBudget(title, amount,
          from: from, to: to, desc: desc);
      _storage.addBudget(newBudget);

      _listState.currentState?.insertItem(0);

      return Resource.data(data: newBudget);
    } on DioError catch (dio) {
      return Resource.error(
          err: dio.response?.statusMessage ??
              "Something related to dio occured ");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Something unusal occured ");
    }
  }

  Future<void> getBudgetInfo() async {
    try {
      List<BudgetModel> refreshedBudget = await _api.getBudget();

      logger.info('Invalidating cache for budget ');
      await _storage.deleteAllBudget();
      await _storage.addBudgets(refreshedBudget);

      _budgets = BudgetStorage.getBudget();
      emit(BudgetLoadSuccess(data: _budgets));

      for (var element in _budgets) {
        await Future.delayed(
          const Duration(milliseconds: 100),
          () => _listState.currentState?.insertItem(_budgets.indexOf(element)),
        );
      }
    } on DioError catch (err) {
      logger.shout("dio error occured");

      emit(
        BudgetLoadFailed(
            errMessage: err.response?.statusMessage ??
                "Something related to dio occered ",
            data: _budgets),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);

      emit(BudgetLoadFailed(
          errMessage: "Something unusual occured loading from cache ",
          data: _budgets));
    }
  }
}
