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
  final Tween<Offset> _offset =
      Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
  final Tween<double> _opacity = Tween<double>(begin: 0, end: 1);
  final ExpensesClient _clt = ExpensesClient();
  static final ExpenseCategoriesStorage _expenseCategoriesStorage =
      ExpenseCategoriesStorage();
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  bool isLoaded = false;

  GlobalKey<AnimatedListState> get expenseSourceListKey => _key;

  List<ExpenseCategoriesModel> _models =
      _expenseCategoriesStorage.getExpenseCategories();

  List<ExpenseCategoriesModel> get models => _models;

  Future<Resource> deleteExpenseCategory(
      ExpenseCategoriesModel expenseCategoriesModel) async {
    try {
      await _clt.deleteCategory(expenseCategoriesModel);
      if (_key.currentState != null) {
        _key.currentState!.removeItem(
          _models.indexOf(expenseCategoriesModel),
          (context, animation) => FadeTransition(
            opacity: animation.drive<double>(_opacity),
            child: SlideTransition(
              position: animation.drive<Offset>(_offset),
              child: ExpenseCategoryCard(category: expenseCategoriesModel),
            ),
          ),
        );
        _expenseCategoriesStorage.deleteExpenseCategory(expenseCategoriesModel);
        _models.remove(expenseCategoriesModel);
      }
      return ResourceSucess(
          message:
              'Successfully removed category ${expenseCategoriesModel.title}');
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
      ExpenseCategoriesModel? model =
          await _clt.createCategory(title, desc: desc);
      if (_key.currentState != null) {
        _expenseCategoriesStorage.addExpenseCategory(model);
        _models.add(model);
        _key.currentState!.insertItem(_models.length - 1);
      }

      return ResourceSucess<ExpenseCategoriesModel>(data: model);
    } on DioError catch (dio) {
      return ResourceFailed(message: dio.message);
    } catch (e) {
      return ResourceFailed(message: e.toString());
    }
  }

  void getCategories() async {
    try {
      if (!isLoaded) {
        List<ExpenseCategoriesModel>? modelsFromServer =
            await _clt.getCategories();
        if (modelsFromServer != null) {
          logger.info('Invalidating cache');
          _expenseCategoriesStorage.deleteExpenseCategories().then((_) =>
              _expenseCategoriesStorage.addExpenseCategories(modelsFromServer));
        }
        isLoaded = true;
      }
      _models = _expenseCategoriesStorage.getExpenseCategories();
      emit(ExpenseCategoryStateSuccess(data: _models));
      Future future = Future(() {});
      for (var element in _models) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(models.indexOf(element));
              }
            },
          ),
        );
      }
      //   isLoaded = true;
      // }

    } on DioError catch (dio) {
      return emit(
        ExpenseCategoryStateFailed(
          message: dio.error.runtimeType.toString(),
        ),
      );
    } on SocketException {
      _models = _expenseCategoriesStorage.getExpenseCategories();
      emit(ExpenseCategoryStateSuccess(
          data: _models, message: 'NO INTERNET loading from cache'));
    } on HiveError catch (hiveError) {
      logger.shout(hiveError);
    } catch (e) {
      logger.shout(e);
      return emit(ExpenseCategoryStateFailed(message: e.toString()));
    }
  }
}
