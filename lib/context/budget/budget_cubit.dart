import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/dto/details_dto.dart';
import '../../data/local/budget/budget_storage.dart';
import '../../data/remote/budget_api.dart';
import '../../domain/models/models.dart';
import '../../main.dart';
import '../../utils/resource.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetLoad());

  final BudgetStorage _storage = BudgetStorage();

  final BudgetApi _api = BudgetApi();
  final GlobalKey<SliverAnimatedListState> _listState =
      GlobalKey<SliverAnimatedListState>();

  List<BudgetModel> _budgets = BudgetStorage.getBudget();

  List<BudgetModel> get budgets => _budgets;

  GlobalKey<SliverAnimatedListState> get key => _listState;

  Future<Resource<BudgetModel?>> createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc}) async {
    try {
      BudgetModel newBudget = await _api.createBudget(title, amount,
          from: from, to: to, desc: desc);
      // adding to the database
      _storage.addBudget(newBudget);
      // Adding to the referneces
      _budgets = [newBudget, ..._budgets];

      _listState.currentState?.insertItem(0);

      return Resource.data(data: newBudget);
    } on DioError catch (dio) {
      return Resource.error(
          err: dio,
          errorMessage: dio.response?.statusMessage ??
              "Something related to dio occured ");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Something unusal occured ");
    }
  }

  Future<void> getBudgetInfo() async {
    emit(BudgetLoad());
    try {
      List<BudgetModel> refreshedBudget = await _api.getBudget();

      logger.info('Invalidating cache for budget ');
      await _storage.deleteAllBudget();
      await _storage.addBudgets(refreshedBudget);

      _budgets = BudgetStorage.getBudget();
      emit(BudgetLoadSuccess(data: _budgets));
    } on DioError catch (err) {
      emit(
        BudgetLoadFailed(
          errMessage: ErrorDetialsDto.fromJson(
                      (err.response?.data as Map<String, dynamic>))
                  .details ??
              "Something related to dio occered ",
          data: _budgets,
        ),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);

      emit(BudgetLoadFailed(
          errMessage: "Something unusual occured loading from cache ",
          data: _budgets));
    } finally {
      for (final element in _budgets) {
        await Future.delayed(
          const Duration(milliseconds: 100),
          () => _listState.currentState?.insertItem(_budgets.indexOf(element)),
        );
      }
    }
  }
}
