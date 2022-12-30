import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../context.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

part 'income_state.dart';

part 'income_cubit.freezed.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit(this._repo) : super(IncomeState.loading());

  final IncomeRepostiory _repo;

  final Notifier<IncomeSourceModel> notifier = Notifier<IncomeSourceModel>();

  final UiEventCubit<IncomeModel> _uiEvent = UiEventCubit<IncomeModel>();

  UiEventCubit<IncomeModel> get uiEvent => _uiEvent;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  void addIncomeSources(IncomeSourceModel sourceModel) =>
      notifier.check(sourceModel);

  Future<List<IncomeSourceModel>> get cachedSources => _repo.cachedSources();

  Future<void> clearCache() async {
    await _repo.clearcachedIncomes();
    await _repo.clearcachedSources();
  }

  Future<void> addIncome(CreateIncomeModel income) async {
    Resource<IncomeModel?> newIncome = await _repo.createIncome(income);

    newIncome.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog(
          "Refresh and try again ",
          content: "Your icnome is createdrefresh the list to check it",
        ),
        noData: (_) =>
            data != null ? emit(IncomeState.data(data: [data])) : null,
        data: (preData, _) {
          List<IncomeModel> newSet = preData.toList()..add(data!);
          emit(IncomeState.data(data: newSet, message: message));
          key.currentState?.insertItem(newSet.length - 1);
          _uiEvent.showSnackBar(
              message ?? "Added new income titled : ${data.title}");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showDialog(
          "Cannot add income ${income.title}. ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> deleteIncome(
    IncomeModel income, {
    required Widget widget,
  }) async {
    Resource<void> remove = await _repo.deleteIncome(income);

    remove.whenOrNull(
      data: (_, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog(
          "Refresh and try again",
          content: "Your income has been removed please refresh to see results",
        ),
        data: (preData, _) {
          int index = preData.indexOf(income);
          _key.currentState?.removeItem(
            index,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );
          List<IncomeModel> newSet = preData.toList()..removeAt(index);
          if (newSet.isEmpty) {
            emit(IncomeState.noData(message: "No data found"));
            return;
          }
          emit(IncomeState.data(data: newSet));
          _uiEvent.showSnackBar(
              message ?? "Removed income titled: ${income.title}");
        },
      ),
      error: (err, errorMessage, _) => _uiEvent.showSnackBar(
          "Cannot delete income ${income.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> updateIncome(UpdateIncomeModel income) async {
    Resource<IncomeModel?> updatedExpense = await _repo.updateIncome(income);

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
              prevData.toList().indexWhere((item) => item.id == income.id);

          List<IncomeModel> newSet = prevData.toList()
            ..removeWhere((item) => item.id == income.id)
            ..insert(index, data);

          emit(IncomeState.data(data: newSet));
          _uiEvent.showSnackBar("Goal: ${data.title} has been updated.");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(
          "Cannot update expense ${income.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> getIncomes() async {
    emit(IncomeState.loading());

    Resource<List<IncomeModel>> incomes = await _repo.getIncomes();

    incomes.whenOrNull(
      data: (data, message) => (data.isEmpty)
          ? emit(IncomeState.noData(message: "No data"))
          : emit(IncomeState.data(data: data, message: message)),
      error: (err, errorMessage, data) => (data != null && data.isNotEmpty)
          ? emit(IncomeState.errorWithData(
              errMessage: errorMessage, err: err, data: data))
          : emit(IncomeState.error(errMessage: errorMessage, err: err)),
    );
  }
}
