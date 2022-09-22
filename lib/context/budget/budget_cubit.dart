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

  static final BudgetStorage _storage = BudgetStorage();

  final BudgetApi _api = BudgetApi();
  final GlobalKey<AnimatedListState> _listState =
      GlobalKey<AnimatedListState>();

  List<BudgetModel> _budgets = _storage.getBudget();

  List<BudgetModel> get budgets => _budgets;

  GlobalKey<AnimatedListState> get key => _listState;

  Future<Resource<BudgetModel?>> createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc}) async {
    try {
      BudgetModel newBudget = await _api.createBudget(title, amount,
          from: from, to: to, desc: desc);
      _storage.addBudget(newBudget);

      // _listState.currentState?.insertItem(0);

      return ResourceSucess(data: newBudget);
    } on DioError catch (dio) {
      logger.shout(dio.response?.data);
      return ResourceFailed(message: dio.message);
    } catch (e) {
      logger.shout(e.toString());
      return ResourceFailed(message: e.toString());
    }
  }

  Future<void> getBudgetInfo() async {
    try {
      List<BudgetModel> refreshedBudget = await _api.getBudget();

      logger.info('Invalidating cache for budget ');
      await _storage.deleteAllBudget();
      await _storage.addBudgets(refreshedBudget);

      _budgets = _storage.getBudget();
      emit(BudgetLoadSuccess(data: _budgets));
      Future future = Future(() {});
      for (var element in _budgets) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 100),
            () {
              if (_listState.currentState == null) return;
              _listState.currentState!.insertItem(_budgets.indexOf(element));
            },
          ),
        );
      }
    } catch (e) {
      emit(BudgetLoadFailed(message: ''));
      logger.shout(e.toString());
    }
  }
}
