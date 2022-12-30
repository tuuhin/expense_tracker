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

  Future<List<BudgetModel>> cachedBudget() => _repo.cachedBudget();

  Future<void> clearCache() async => await _repo.clearCache();

  Future<void> addBudget(CreateBudgetModel budget) async {
    Resource<BudgetModel?> newBudget = await _repo.createBudget(budget);

    newBudget.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showSnackBar(
            "Your budget titled ${budget.title} has been added refresh to see changes"),
        noData: (message) => data != null
            ? emit(BudgetState.data(data: [data], message: message))
            : null,
        data: (prevData, message) {
          if (data == null) return;
          List<BudgetModel> newSet = prevData.toList()..add(data);

          emit(BudgetState.data(
              data: newSet, message: message ?? "New budget added"));
          _key.currentState?.insertItem(newSet.length - 1);
          _uiEvent.showSnackBar(
              "Your budget titled ${budget.title} has been created.");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent
          .showDialog("Failed to add your budget", content: errorMessage),
    );
  }

  Future<void> deleteBudget(
    BudgetModel budget, {
    required Widget widget,
  }) async {
    Resource<void> response = await _repo.deleteBudget(budget);

    response.whenOrNull(
      data: (_, message) => state.maybeWhen(
        orElse: () => _uiEvent.showSnackBar(
            "Your budget titled ${budget.title} has been deleted refresh to see changes"),
        data: (prevData, _) {
          int index = prevData.indexOf(budget);
          _key.currentState?.removeItem(
            index,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );
          List<BudgetModel> newData = prevData.toList()..remove(budget);

          if (newData.isEmpty) {
            emit(BudgetState.noData(message: message ?? "No budgets found"));
            return;
          }
          emit(BudgetState.data(data: newData, message: message));

          _uiEvent.showSnackBar(
              "Your budget titled ${budget.title} has been deleted");
        },
      ),
      error: (err, errorMessage, _) => _uiEvent.showDialog(
          "Failed to delete budget titled : ${budget.title}",
          content: errorMessage),
    );
  }

  Future<void> updateBudget(BudgetModel budget) async {
    Resource<BudgetModel?> update = await _repo.updateBudget(budget);

    update.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent
            .showSnackBar(message ?? "Updated budget: ${data?.title ?? ''}"),
        data: (prevData, _) {
          if (data == null) return;
          int index =
              prevData.toList().indexWhere((item) => item.id == budget.id);
          List<BudgetModel> newSet = prevData.toList()
            ..removeWhere((item) => item.id == budget.id)
            ..insert(index, data);

          emit(BudgetState.data(data: newSet));
          _uiEvent.showSnackBar("Budget: ${data.title} has been updated.");
        },
      ),
      error: (err, errorMessage, __) => _uiEvent.showDialog(
          "Cannot update your Budget: ${budget.title}",
          content: errorMessage),
    );
  }

  Future<void> getBudgetInfo() async {
    emit(BudgetState.loading());

    Resource<List<BudgetModel>> budgets = await _repo.getBudget();

    budgets.whenOrNull(
      data: (data, message) => data.isEmpty
          ? emit(BudgetState.noData(message: "No data"))
          : emit(BudgetState.data(data: data, message: message)),
      error: (err, errorMessage, data) => data != null && data.isNotEmpty
          ? emit(BudgetState.errorWithData(
              error: err, message: errorMessage, data: data))
          : emit(BudgetState.error(error: err, message: errorMessage)),
    );
  }
}
