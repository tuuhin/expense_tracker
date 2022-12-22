import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/resource.dart';
import '../../context/context.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

part 'budget_state.dart';
part 'budget_cubit.freezed.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit(this._repo) : super(BudgetState.loading());

  final BudgetRepository _repo;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  final UiEventCubit<BudgetModel> _uiEvent = UiEventCubit<BudgetModel>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  UiEventCubit<BudgetModel> get uievent => _uiEvent;

  List<BudgetModel> cachedBudget() => _repo.cachedBudget();

  Future<void> addBudget(CreateBudgetModel budget) async {
    Resource<BudgetModel?> newBudget = await _repo.createBudget(budget);

    newBudget.whenOrNull(
        data: (data, message) {
          if (state is! _Data && data != null) {
            _uiEvent.showDialog("Refresh",
                content:
                    "Your budget has been created all you need to do id to refresh");
            return;
          }
          List<BudgetModel> newSet = (state as _Data).data.toList()..add(data!);

          emit(BudgetState.data(data: newSet, message: "New budget added"));
          _key.currentState?.insertItem(newSet.length - 1);
          _uiEvent.showSnackBar(
              "Your budget titled ${budget.title} has been created.");
        },
        error: (err, errorMessage, data) => _uiEvent
            .showDialog("Failed to add your budget", content: errorMessage));
  }

  Future<void> deleteBudget(BudgetModel budget,
      {required Widget widget}) async {
    Resource<void> res = await _repo.deleteBudget(budget);
    res.whenOrNull(
      data: (data, message) {
        if (state is! _Data) {
          _uiEvent.showSnackBar(
              "Your budget titled ${budget.title} has been deleted refresh to see changes");
          return;
        }

        int index = (state as _Data).data.indexOf(budget);
        _key.currentState?.removeItem(
          index,
          (context, animation) =>
              SizeTransition(sizeFactor: animation, child: widget),
        );
        List<BudgetModel> newData = (state as _Data).data.toList()
          ..remove(budget);

        emit(BudgetState.data(data: newData));
        _uiEvent.showSnackBar(
            "Your budget titled ${budget.title} has been deleted");
      },
      error: (err, errorMessage, data) => _uiEvent.showDialog(
          "Failed to delete budget titled : ${budget.title}",
          content: errorMessage),
    );
  }

  Future<void> updateBudget(BudgetModel budget) async {
    Resource<BudgetModel?> update = await _repo.updateBudget(budget);

    update.whenOrNull(
      data: (data, message) => _uiEvent
          .showSnackBar(message ?? "Updated budget: ${data?.title ?? ''}"),
      error: (err, errorMessage, data) => _uiEvent
          .showDialog("Cannot update your budget", content: errorMessage),
    );
  }

  Future<void> getBudgetInfo() async {
    emit(BudgetState.loading());

    Resource<List<BudgetModel>> budgets = await _repo.getBudget();

    budgets.whenOrNull(
      data: (data, message) async {
        if (data.isEmpty) {
          emit(BudgetState.noData(message: "No data"));
          return;
        }
        emit(BudgetState.data(data: data, message: message));
      },
      error: (err, errorMessage, data) {
        if (data != null && data.isNotEmpty) {
          emit(BudgetState.errorWithData(
              error: err, message: errorMessage, data: data));
          return;
        }
        emit(BudgetState.error(error: err, message: errorMessage));
      },
    );
  }
}
