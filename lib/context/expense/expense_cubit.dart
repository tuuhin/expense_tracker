import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';
import '../context.dart';

part 'expense_state.dart';
part 'expense_cubit.freezed.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit(this._repo) : super(ExpenseState.loading());

  final ExpenseRespository _repo;

  final UiEventCubit<ExpenseModel> _uiEvent = UiEventCubit<ExpenseModel>();

  final Notifier<ExpenseCategoriesModel> _categories =
      Notifier<ExpenseCategoriesModel>();

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  Notifier<ExpenseCategoriesModel> get notifier => _categories;

  GlobalKey<SliverAnimatedListState> get key => _key;

  UiEventCubit<ExpenseModel> get uiEvent => _uiEvent;

  Future<List<ExpenseCategoriesModel>> get cahedCategories async =>
      _repo.cachedCategories();

  Future<void> clearCache() async {
    await _repo.clearCategoryCached();
    await _repo.clearExpenseCached();
  }

  Future<void> addExpense(CreateExpenseModel expense) async {
    Resource<ExpenseModel?> newExpense = await _repo.createExpense(expense);

    newExpense.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog(
          "Refresh and try again ",
          content: "Your icnome is createdrefresh the list to check it",
        ),
        noData: (_) =>
            data != null ? emit(ExpenseState.data(data: [data])) : null,
        data: (preData, _) {
          List<ExpenseModel> newSet = preData.toList()..add(data!);
          emit(ExpenseState.data(data: newSet, message: message));
          key.currentState?.insertItem(0);
          _uiEvent.showSnackBar(
              message ?? "Added new income titled : ${data.title}");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showDialog(
          "Cannot add income ${expense.title}. ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> deleteExpense(
    ExpenseModel expense, {
    required Widget widget,
  }) async {
    Resource<void> remove = await _repo.deleteExpense(expense);

    remove.whenOrNull(
      data: (_, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog(
          "Refresh and try again",
          content:
              "Your expense has been removed please refresh to see results",
        ),
        data: (preData, _) {
          int index = preData.indexOf(expense);
          _key.currentState?.removeItem(
            index,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );
          List<ExpenseModel> newSet = preData.toList()..removeAt(index);
          newSet.isEmpty
              ? emit(ExpenseState.noData(message: "No data found"))
              : emit(ExpenseState.data(data: newSet));
          _uiEvent.showSnackBar(
              message ?? "Removed income titled: ${expense.title}");
        },
      ),
      error: (err, errorMessage, _) => _uiEvent.showSnackBar(
          "Cannot delete income ${expense.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> updateExpense(UpdateExpenseModel expense) async {
    Resource<ExpenseModel?> updatedExpense = await _repo.updateExpense(expense);

    updatedExpense.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog(
          "Refresh and try again",
          content:
              "Your expense has been removed please refresh to see results",
        ),
        data: (prevData, _) {
          if (data == null) return;

          int index =
              prevData.toList().indexWhere((item) => item.id == expense.id);
          List<ExpenseModel> newSet = prevData.toList()
            ..removeWhere((item) => item.id == expense.id)
            ..insert(index, data);

          emit(ExpenseState.data(data: newSet));
          _uiEvent.showSnackBar("Goal: ${data.title} has been updated.");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(
          "Cannot update expense ${expense.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> getExpenses() async {
    emit(ExpenseState.loading());

    Resource<List<ExpenseModel>> budgets = await _repo.getExpense();

    budgets.whenOrNull(
      data: (data, message) => data.isEmpty
          ? emit(ExpenseState.noData(message: "No data"))
          : emit(ExpenseState.data(data: data, message: message)),
      error: (err, errorMessage, data) => data != null && data.isNotEmpty
          ? emit(ExpenseState.errorWithData(
              data: data, err: err, errMessage: errorMessage))
          : emit(ExpenseState.error(errMessage: errorMessage, err: err)),
    );
  }
}
