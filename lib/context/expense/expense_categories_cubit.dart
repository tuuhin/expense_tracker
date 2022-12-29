import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../context.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

part 'expense_categories_state.dart';

part 'expense_categories_cubit.freezed.dart';

class ExpenseCategoriesCubit extends Cubit<ExpenseCategoryState> {
  ExpenseCategoriesCubit(this._repo) : super(ExpenseCategoryState.loading());

  final ExpenseRespository _repo;

  final UiEventCubit<ExpenseCategoriesModel> _uiEventCubit =
      UiEventCubit<ExpenseCategoriesModel>();

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  UiEventCubit<ExpenseCategoriesModel> get uiEvent => _uiEventCubit;

  GlobalKey<SliverAnimatedListState> get key => _key;

  Future<void> removeCategory(
    ExpenseCategoriesModel category, {
    required Widget widget,
  }) async {
    Resource<void> delete = await _repo.deleteCategory(category);

    delete.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEventCubit.showDialog(
          "Refresh and try again ",
          content:
              "The category titled ${category.title} created.Refresh to see reuslts",
        ),
        data: (preData, _) {
          int itemIndex = preData.indexOf(category);

          key.currentState?.removeItem(
            itemIndex,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );
          List<ExpenseCategoriesModel> newSet = preData.toList()
            ..removeAt(itemIndex);
          newSet.isEmpty
              ? emit(ExpenseCategoryState.noData())
              : emit(ExpenseCategoryState.data(data: newSet));
          _uiEventCubit.showSnackBar("Removed category ${category.title}");
        },
      ),
      error: (err, errorMessage, data) => _uiEventCubit.showSnackBar(
          "Cannot delete category ${category.title}. Error Occured :$errorMessage"),
    );
  }

  Future<void> createCategory(CreateCategoryModel category) async {
    Resource<ExpenseCategoriesModel?> newCategory =
        await _repo.createCategory(category);

    newCategory.whenOrNull(
      data: (data, message) => state.maybeWhen(
        orElse: () => _uiEventCubit.showDialog(
          "Refresh and try again ",
          content:
              "The category titled ${category.title} created.Refresh to see reuslts",
        ),
        noData: (_) =>
            data != null ? emit(ExpenseCategoryState.data(data: [data])) : null,
        data: (prevData, _) {
          List<ExpenseCategoriesModel> newSet = prevData.toList()..add(data!);
          int itemIndex = newSet.indexOf(data);

          emit(ExpenseCategoryState.data(data: newSet, message: message));
          key.currentState?.insertItem(itemIndex);
          _uiEventCubit.showSnackBar("Added new Category ${data.title}");
        },
      ),
      error: (err, errorMessage, data) => _uiEventCubit.showDialog(
          "Adding category ${category.title} failed ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> getCategories() async {
    emit(ExpenseCategoryState.loading());

    Resource<List<ExpenseCategoriesModel>> categories =
        await _repo.getCategories();

    categories.whenOrNull(
      data: (data, message) async => data.isEmpty
          ? emit(ExpenseCategoryState.noData(message: "No data"))
          : emit(ExpenseCategoryState.data(data: data, message: message)),
      error: (err, errorMessage, data) => data != null && data.isNotEmpty
          ? emit(ExpenseCategoryState.errorWithData(
              data: data, err: err, errMessage: errorMessage))
          : emit(
              ExpenseCategoryState.error(errMessage: errorMessage, err: err)),
    );
  }
}
