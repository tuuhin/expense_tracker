import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'expense_categories_state.dart';

part 'expense_categories_cubit.freezed.dart';

class ExpenseCategoriesCubit extends Cubit<ExpenseCategoryState> {
  ExpenseCategoriesCubit(this._repo) : super(ExpenseCategoryState.loading());

  final ExpenseRespository _repo;

  GlobalKey<SliverAnimatedListState> get key => _key;
  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  Future<void> removeCategory(ExpenseCategoriesModel category,
      {required Widget widget}) async {
    Resource<void> delete = await _repo.deleteCategory(category);

    delete.whenOrNull(
      data: (data, message) {
        if (state is! _Success) return;

        int itemIndex = (state as _Success).data.indexOf(category);

        key.currentState?.removeItem(
          itemIndex,
          (context, animation) =>
              SizeTransition(sizeFactor: animation, child: widget),
        );

        List<ExpenseCategoriesModel> newCategorySet =
            (state as _Success).data.toList()..removeAt(itemIndex);

        emit(ExpenseCategoryState.data(data: newCategorySet, message: message));
      },
    );
  }

  Future<void> createCategory(CreateCategoryModel category) async {
    Resource<ExpenseCategoriesModel?> newCategory =
        await _repo.createCategory(category);

    newCategory.whenOrNull(
      data: (data, message) {
        if (state is! _Success && data != null) return;

        emit(ExpenseCategoryState.data(
            data: [data!, ...(state as _Success).data], message: message));

        key.currentState?.insertItem(0);
      },
      error: (err, errorMessage, data) {
        if (state is! _Success) return;
        emit(
          ExpenseCategoryState.data(
              data: [...(state as _Success).data],
              message: "Cannot add category"),
        );
      },
    );
  }

  Future<void> getCategories() async {
    emit(ExpenseCategoryState.loading());

    Resource<List<ExpenseCategoriesModel>> budgets =
        await _repo.getCategories();

    budgets.when(
      loading: () {},
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
