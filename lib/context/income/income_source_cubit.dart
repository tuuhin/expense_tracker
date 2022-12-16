import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../utils/resource.dart';
import '../../domain/repositories/repositories.dart';
import '../context.dart';

part 'income_source_state.dart';

part 'income_source_cubit.freezed.dart';

class IncomeSourceCubit extends Cubit<IncomeSourceState> {
  IncomeSourceCubit(this._repo) : super(IncomeSourceState.loading());

  final IncomeRepostiory _repo;

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  final UiEventCubit<IncomeSourceModel> _uiEvent =
      UiEventCubit<IncomeSourceModel>();

  GlobalKey<SliverAnimatedListState> get incomeListKey => _key;

  UiEventCubit<IncomeSourceModel> get uiEvent => _uiEvent;

  Future<void> deleteSource(
    IncomeSourceModel source, {
    required Widget widget,
  }) async {
    Resource<void> delete = await _repo.deleteSource(source);
    delete.whenOrNull(
        data: (data, message) {
          if (state is! _Success) {
            _uiEvent.showSnackBar(
                "Source titled: ${source.title} has been removed refresh to see changes");
            return;
          }

          int itemIndex = (state as _Success).data.indexOf(source);

          _key.currentState?.removeItem(
            itemIndex,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );

          List<IncomeSourceModel> newSourceSet =
              (state as _Success).data.toList()..removeAt(itemIndex);

          emit(IncomeSourceState.data(data: newSourceSet, message: message));

          _uiEvent.showSnackBar("Removed category ${source.title}");
        },
        error: (err, errorMessage, data) => _uiEvent.showSnackBar(
            "Cannot delete category ${source.title}. Error Occured :$errorMessage"));
  }

  Future<void> addSource(CreateIncomeSourceModel source) async {
    Resource<IncomeSourceModel?> newSource = await _repo.createSource(source);

    newSource.whenOrNull(
        data: (data, message) {
          if (state is! _Success) {
            _uiEvent.showSnackBar("Your source is added ,refresh to see them");
            return;
          }

          List<IncomeSourceModel> newSourceSet =
              (state as _Success).data.toList()..add(data!);

          int itemIndex = newSourceSet.indexOf(data);

          emit(IncomeSourceState.data(data: newSourceSet));
          _key.currentState?.insertItem(itemIndex);
          _uiEvent.showSnackBar("Source titled ${source.title} has been added");
        },
        error: (err, errorMessage, data) =>
            _uiEvent.showSnackBar(errorMessage));
  }

  Future<void> getIncomeSources() async {
    emit(IncomeSourceState.loading());

    Resource<List<IncomeSourceModel>> sources = await _repo.getSources();

    sources.whenOrNull(
      data: (data, message) {
        if (data.isEmpty) {
          emit(IncomeSourceState.noData(message: "No data"));
          return;
        }
        emit(IncomeSourceState.data(data: data, message: message));
      },
      error: (err, errorMessage, data) {
        if (data != null && data.isNotEmpty) {
          emit(IncomeSourceState.errorWithData(
              errMessage: errorMessage, err: err, data: data));
          return;
        }
        emit(IncomeSourceState.error(errMessage: errorMessage, err: err));
      },
    );
  }
}
