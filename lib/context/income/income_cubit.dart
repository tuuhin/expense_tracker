import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/context/income/income_source_notifier.dart';
import 'package:expense_tracker/data/local/income/income_storage.dart';
import 'package:expense_tracker/data/remote/income_api.dart';
import 'package:expense_tracker/domain/models/income/income_models.dart';
import 'package:expense_tracker/domain/models/income/income_source_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit() : super(IncomeLoading());

  final IncomeSourceNotifier _incomeSourceNotifier = IncomeSourceNotifier();

  final IncomeApi _incomeClient = IncomeApi();
  static final IncomeStorage _storage = IncomeStorage();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  List<IncomeModel> _incomes = [];

  IncomeSourceNotifier get notifier => _incomeSourceNotifier;

  GlobalKey<AnimatedListState> get key => _key;

  void addIncomeSources(IncomeSourceModel sourceModel) {
    _incomeSourceNotifier.checkSource(sourceModel);
  }

  Future<Resource<IncomeModel?>> addIncome(
    String title,
    double amount, {
    String? desc,
    List<IncomeSourceModel>? sources,
  }) async {
    try {
      IncomeModel? model = await _incomeClient.createIncome(title, amount,
          desc: desc, sources: sources);

      return ResourceSucess(data: model);
    } on DioError catch (error) {
      logger.shout(error);
      return ResourceFailed(message: 'DIO ERROR');
    }
  }

  void deleteIncome(IncomeModel incomeModel) {}

  Future<void> getIncomes() async {
    try {
      List<IncomeModel>? modelsFromServer = await _incomeClient.getIcomes();
      if (modelsFromServer != null) {
        logger.info('Invalidating cache for incomes');
        await _storage.deleteIncomeModels();
        await _storage.addIncomes(modelsFromServer);
      }
      _incomes = _storage.getIncomes();
      emit(IncomeLoadSuccess(data: _incomes));
      Future future = Future(() {});
      for (var element in _incomes) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(_incomes.indexOf(element));
              }
            },
          ),
        );
      }
    } on DioError catch (dio) {
      emit(IncomeLoadFailed(message: dio.message));
    } catch (e) {
      emit(IncomeLoadFailed(message: e.toString()));
    }
  }
}
