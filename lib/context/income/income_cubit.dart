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

  final UiEventCubit<IncomeCubit> _uiEvent = UiEventCubit<IncomeCubit>();

  UiEventCubit<IncomeCubit> get uiEvent => _uiEvent;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  GlobalKey<SliverAnimatedListState> get key => _key;

  void addIncomeSources(IncomeSourceModel sourceModel) =>
      notifier.check(sourceModel);

  List<IncomeSourceModel> get sources => _repo.cachedSources();

  Future<void> addIncome(CreateIncomeModel income) async {
    Resource<IncomeModel?> newIncome = await _repo.createIncome(income);

    newIncome.whenOrNull(
      data: (data, message) {
        if (state is! _Data && data != null) {
          _uiEvent.showDialog(
            "Refresh and try again ",
            content:
                "The category is created but could not be shown because the rest categories aren't load properly",
          );
          return;
        }
        List<IncomeModel> newSet = (state as _Data).data.toList()..add(data!);

        int itemIndex = newSet.indexOf(data);

        emit(IncomeState.data(data: newSet, message: message));

        key.currentState?.insertItem(itemIndex);

        _uiEvent.showSnackBar("Added new Category ${data.title}");
      },
      error: (err, errorMessage, data) => _uiEvent.showDialog(
          "Cannot add category ${income.title}. ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> deleteIncome(
    IncomeModel income, {
    required Widget widget,
  }) async {
    Resource<void> remove = await _repo.deleteIncome(income);

    remove.whenOrNull(
      data: (data, message) {
        if (state is! _Data) {
          _uiEvent.showSnackBar(
              "Your income has been removed please refresh to see results");
          return;
        }
        int index = (state as _Data).data.indexOf(income);
        _key.currentState?.removeItem(
          index,
          (context, animation) =>
              SizeTransition(sizeFactor: animation, child: widget),
        );

        List<IncomeModel> newIncomeSet = (state as _Data).data.toList()
          ..removeAt(index);

        emit(IncomeState.data(data: newIncomeSet, message: message));

        _uiEvent.showSnackBar("Removed category ${income.title}");
      },
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(
          "Cannot delete category ${income.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> getIncomes() async {
    emit(IncomeState.loading());

    Resource<List<IncomeModel>> incomes = await _repo.getIncomes();

    incomes.whenOrNull(
      data: (data, message) {
        if (data.isEmpty) {
          emit(IncomeState.noData(message: "No data"));
          return;
        }
        emit(IncomeState.data(data: data, message: message));
      },
      error: (err, errorMessage, data) {
        if (data != null && data.isNotEmpty) {
          emit(IncomeState.errorWithData(
              errMessage: errorMessage, err: err, data: data));
          return;
        }
        emit(IncomeState.error(errMessage: errorMessage, err: err));
      },
    );
  }
}
