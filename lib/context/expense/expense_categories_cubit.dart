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
        data: (data, message) {
          if (state is! _Success) {
            return;
          }

          int itemIndex = (state as _Success).data.indexOf(category);

          key.currentState?.removeItem(
            itemIndex,
            (context, animation) =>
                SizeTransition(sizeFactor: animation, child: widget),
          );

          List<ExpenseCategoriesModel> newCategorySet =
              (state as _Success).data.toList()..removeAt(itemIndex);

          emit(ExpenseCategoryState.data(
              data: newCategorySet, message: message));

          _uiEventCubit.showSnackBar("Removed category ${category.title}");
        },
        error: (err, errorMessage, data) => _uiEventCubit.showSnackBar(
            "Cannot delete category ${category.title}. Error Occured :$errorMessage"));
  }

  Future<void> createCategory(CreateCategoryModel category) async {
    Resource<ExpenseCategoriesModel?> newCategory =
        await _repo.createCategory(category);

    newCategory.whenOrNull(
      data: (data, message) {
        if (state is! _Success && data != null) {
          _uiEventCubit.showDialog(
            "Refresh and try again ",
            content:
                "The category titled ${category.title} created.Refresh to see reuslts",
          );
          return;
        }

        emit(ExpenseCategoryState.data(
            data: [data!, ...(state as _Success).data], message: message));

        key.currentState?.insertItem(0);

        _uiEventCubit.showSnackBar("Added new Category ${data.title}");
      },
      error: (err, errorMessage, data) => _uiEventCubit.showDialog(
          "Adding category ${category.title} failed ",
          content: "Error Occured :$errorMessage "),
    );
  }

  Future<void> getCategories() async {
    emit(ExpenseCategoryState.loading());

    Resource<List<ExpenseCategoriesModel>> categoies =
        await _repo.getCategories();

    categoies.whenOrNull(
      data: (data, message) async {
        if (data.isEmpty) {
          emit(ExpenseCategoryState.noData(message: "No data"));
          return;
        }
        emit(ExpenseCategoryState.data(data: data, message: message));
      },
      error: (err, errorMessage, data) {
        if (data != null && data.isNotEmpty) {
          emit(ExpenseCategoryState.errorWithData(
              data: data, err: err, errMessage: errorMessage));
          return;
        }
        emit(ExpenseCategoryState.error(errMessage: errorMessage, err: err));
      },
    );
  }
}
