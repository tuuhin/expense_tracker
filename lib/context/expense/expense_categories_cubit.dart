import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  final ExpenseCategoriesStorage _expenseCategoriesStorage =
      ExpenseCategoriesStorage();

  List<ExpenseCategoriesModel> _models =
      ExpenseCategoriesStorage.getExpenseCategories();
  List<ExpenseCategoriesModel> get models => _models;

  GlobalKey<AnimatedListState> get expenseSourceListKey => _key;
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  Future<Resource> deleteExpenseCategory(ExpenseCategoriesModel model) async {
    try {
      await _expensesApi.deleteCategory(model);
      int index = _models.indexOf(model);
      if (_key.currentState != null) {
        _key.currentState!.removeItem(
          index,
          (context, animation) => SlideAndFadeTransition(
            animation: animation,
            child: ExpenseCategoryCard(category: model),
          ),
        );
        await _expenseCategoriesStorage.deleteExpenseCategory(model);
        _models.remove(model);
      }
      return ResourceSucess(
          message: 'Successfully removed category ${model.title}');
    } on DioError catch (dio) {
      return ResourceFailed(message: dio.message);
    } on SocketException {
      return ResourceFailed(message: 'NO INTERNET');
    } catch (e) {
      return ResourceFailed(message: e.toString());
    }
  }

  Future<Resource<ExpenseCategoriesModel?>> addExpenseCategory(
    String title, {
    String? desc,
  }) async {
    try {
      ExpenseCategoriesModel? newCategory =
          await _expensesApi.createCategory(title, desc: desc);
      if (_key.currentState != null) {
        _expenseCategoriesStorage.addExpenseCategory(newCategory);
        _models.add(newCategory);
        _key.currentState!.insertItem(_models.length - 1);
      }
      return ResourceSucess<ExpenseCategoriesModel>(data: newCategory);
    } on DioError catch (dio) {
      return ResourceFailed(message: dio.message);
    } catch (e) {
      return ResourceFailed(message: e.toString());
    }
  }

  void getCategories() async {
    try {
      List<ExpenseCategoriesModel>? updatedCategories =
          await _expensesApi.getCategories();
      if (updatedCategories != null) {
        logger.info('Invalidating cache for expense_categories');
        await _expenseCategoriesStorage.deleteExpenseCategories();
        await _expenseCategoriesStorage.addExpenseCategories(updatedCategories);
      }
      _models = ExpenseCategoriesStorage.getExpenseCategories();
      emit(ExpenseCategoryStateSuccess(data: _models));
      Future future = Future(() {});
      for (var element in _models) {
        int index = models.indexOf(element);
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState == null) return;
              _key.currentState!.insertItem(index);
            },
          ),
        );
      }
    } on DioError catch (dio) {
      return emit(ExpenseCategoryStateFailed(
          message: dio.error.runtimeType.toString()));
    } on SocketException {
      _models = ExpenseCategoriesStorage.getExpenseCategories();
      emit(ExpenseCategoryStateSuccess(
          data: _models, message: 'NO INTERNET lOADING ITEMS FROM CACHE'));
    } on HiveError catch (hiveError) {
      logger.shout(hiveError);
    } catch (e) {
      logger.shout(e);
      return emit(ExpenseCategoryStateFailed(message: e.toString()));
    }
  }
}
