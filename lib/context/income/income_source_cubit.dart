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
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog("Refresh to view",
            content:
                "Source titled: ${source.title} has been removed refresh to see changes"),
        data: (preData, _) {
          int itemIndex = preData.indexOf(source);
          _key.currentState?.removeItem(
            itemIndex,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );
          List<IncomeSourceModel> newSet = preData.toList()
            ..removeAt(itemIndex);

          newSet.isEmpty
              ? emit(IncomeSourceState.noData())
              : emit(IncomeSourceState.data(data: newSet));
          _uiEvent.showSnackBar("Removed source titled: ${source.title}");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(
          "Cannot delete source titled: ${source.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> addSource(CreateIncomeSourceModel source) async {
    Resource<IncomeSourceModel?> newSource = await _repo.createSource(source);

    newSource.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEvent.showDialog("Refresh to view",
            content: "Your source is added please refresh to view"),
        noData: (_) =>
            data != null ? emit(IncomeSourceState.data(data: [data])) : null,
        data: (preData, _) {
          List<IncomeSourceModel> newSourceSet = preData.toList()..add(data!);

          int itemIndex = newSourceSet.indexOf(data);

          emit(IncomeSourceState.data(data: newSourceSet));
          _key.currentState?.insertItem(itemIndex);
          _uiEvent.showSnackBar(
              message ?? "Source titled ${source.title} has been added");
        },
      ),
      error: (err, errorMessage, data) => _uiEvent.showSnackBar(errorMessage),
    );
  }

  Future<void> getIncomeSources() async {
    emit(IncomeSourceState.loading());

    Resource<List<IncomeSourceModel>> sources = await _repo.getSources();

    sources.whenOrNull(
      data: (data, message) => data.isEmpty
          ? emit(IncomeSourceState.noData(message: "No data"))
          : emit(IncomeSourceState.data(data: data, message: message)),
      error: (err, errorMessage, data) => data != null && data.isNotEmpty
          ? emit(IncomeSourceState.errorWithData(
              errMessage: errorMessage, err: err, data: data))
          : emit(IncomeSourceState.error(errMessage: errorMessage, err: err)),
    );
  }
}
