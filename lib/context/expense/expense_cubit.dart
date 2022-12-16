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

  List<ExpenseCategoriesModel> get categories => _repo.cachedCategories();

  Future<void> addExpense(CreateExpenseModel expense) async {
    Resource<ExpenseModel?> newExpense = await _repo.createExpense(expense);

    newExpense.whenOrNull(
      data: (data, message) {
        if (state is! _Data && data != null) {
          _uiEvent.showDialog(
            "Refresh and try again ",
            content:
                "The expense titled ${expense.title} created.Refresh to see reuslts",
          );
          return;
        }

        List<ExpenseModel> newSet = (state as _Data).data.toList()..add(data!);

        emit(ExpenseState.data(data: newSet, message: message));

        key.currentState?.insertItem(0);

        _uiEvent.showSnackBar("Added new expense ${data.title}");
      },
      error: (err, errorMessage, data) => _uiEvent.showDialog(
          "Cannot add category ${expense.title}. ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> deleteExpense(
    ExpenseModel expense, {
    required Widget widget,
  }) async {
    Resource<void> removedExpense = await _repo.deleteExpense(expense);

    removedExpense.whenOrNull(
      data: (data, message) {
        if (state is! _Data) {
          _uiEvent.showSnackBar(
              "Your expense has been removed please refresh to see results");
          return;
        }
        int index = (state as _Data).data.indexOf(expense);
        _key.currentState?.removeItem(
          index,
          (context, animation) =>
              SizeTransition(sizeFactor: animation, child: widget),
        );

        List<ExpenseModel> newExpenseSet = (state as _Data).data.toList()
          ..removeAt(index);

        emit(ExpenseState.data(data: newExpenseSet, message: message));

        _uiEvent.showSnackBar("Removed expense ${expense.title}");
        return;
      },
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(
          "Cannot delete expense ${expense.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> updateExpense(ExpenseModel expense) async {}

  Future<void> getExpenses() async {
    emit(ExpenseState.loading());

    Resource<List<ExpenseModel>> budgets = await _repo.getExpense();

    budgets.when(
      loading: () {},
      data: (data, message) async {
        if (data.isEmpty) {
          emit(ExpenseState.noData(message: "No data"));
          return;
        }
        emit(ExpenseState.data(data: data, message: message));
      },
      error: (err, errorMessage, data) {
        if (data != null && data.isNotEmpty) {
          emit(ExpenseState.errorWithData(
              data: data, err: err, errMessage: errorMessage));
          return;
        }
        emit(ExpenseState.error(errMessage: errorMessage, err: err));
      },
    );
  }
}
