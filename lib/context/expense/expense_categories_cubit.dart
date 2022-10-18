import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/widgets.dart';
import '../../data/local/storage.dart';
import '../../data/remote/remote.dart';
import '../../domain/models/models.dart';
import '../../main.dart';
import '../../utils/resource.dart';

part 'expense_categories_state.dart';

class ExpenseCategoriesCubit extends Cubit<ExpenseCategoryState> {
  ExpenseCategoriesCubit() : super(ExpenseCategoryStateLoading());

  final ExpensesApi _expensesApi = ExpensesApi();
  final ExpenseCategoriesStorage _categoryStore = ExpenseCategoriesStorage();

  List<ExpenseCategoriesModel> _models =
      ExpenseCategoriesStorage.getExpenseCategories();

  List<ExpenseCategoriesModel> get models => _models;

  GlobalKey<AnimatedListState> get expenseSourceListKey => _key;
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  Future<Resource> deleteExpenseCategory(ExpenseCategoriesModel model) async {
    try {
      await _expensesApi.deleteCategory(model);

      _key.currentState?.removeItem(
        _models.indexOf(model),
        (context, animation) => SlideAndFadeTransition(
          animation: animation,
          child: ExpenseCategoryCard(category: model),
        ),
      );
      await _categoryStore.deleteExpenseCategory(model);
      _models = ExpenseCategoriesStorage.getExpenseCategories();

      return Resource.data(
          data: [], message: 'Successfully removed category ${model.title}');
    } on DioError catch (dio) {
      return Resource.error(
          err: dio.response?.statusMessage ??
              "Something related to dio occured ");
    } on SocketException {
      return Resource.error(
          err: "Something related to internet occured  occured ");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: "Unknown error");
    }
  }

  Future<Resource<ExpenseCategoriesModel?>> addExpenseCategory(
    String title, {
    String? desc,
  }) async {
    try {
      ExpenseCategoriesModel newCategory =
          await _expensesApi.createCategory(title, desc: desc);
      _categoryStore.addExpenseCategory(newCategory);
      _models.add(newCategory);
      _key.currentState?.insertItem(0);

      return Resource.data(data: newCategory, message: "NEW CATEGORY ADDED");
    } on DioError catch (dio) {
      return Resource.error(
          err: dio.response?.statusMessage ??
              "Something related to dio occured  occured ");
    } catch (e) {
      return Resource.error(
          err: "Something related to internet occured  occured ");
    }
  }

  void getCategories() async {
    try {
      List<ExpenseCategoriesModel>? updatedCategories =
          await _expensesApi.getCategories();
      if (updatedCategories != null) {
        logger.info('Invalidating cache for expense_categories');
        await _categoryStore.deleteExpenseCategories();
        await _categoryStore.addExpenseCategories(updatedCategories);
      }
      _models = ExpenseCategoriesStorage.getExpenseCategories();
      emit(ExpenseCategoryStateSuccess(data: _models));
      for (var element in _models) {
        await Future.delayed(const Duration(milliseconds: 50),
            () => _key.currentState?.insertItem(models.indexOf(element)));
      }
    } on DioError catch (dio) {
      return emit(
        ExpenseCategoryStateFailed(
            errMessage:
                dio.response?.statusMessage ?? "Something related to dio ",
            data: _models),
      );
    } on SocketException {
      emit(ExpenseCategoryStateSuccess(
          data: _models, message: 'NO INTERNET lOADING ITEMS FROM CACHE'));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      emit(ExpenseCategoryStateSuccess(
          data: _models, message: 'UNUSUAL ERROR OCCURED '));
    }
  }
}
