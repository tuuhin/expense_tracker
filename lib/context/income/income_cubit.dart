import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app/home/routes/route_builder.dart';
import '../../app/widgets/income/income_card.dart';
import '../../data/local/storage.dart';
import '../../data/remote/income_api.dart';
import '../../domain/models/income/income_models.dart';
import '../../domain/models/income/income_source_model.dart';
import '../../utils/resource.dart';
import 'income_source_notifier.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit() : super(IncomeLoading());

  final IncomeSourceNotifier _incomeSourceNotifier = IncomeSourceNotifier();
  final IncomeApi _incomeClient = IncomeApi();
  final IncomeStorage _storage = IncomeStorage();
  final IncomeSourceStorage _incomeSourceStorage = IncomeSourceStorage();

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  List<IncomeModel> get _incomes => _storage.getIncomes();

  List<IncomeSourceModel> get allIncomeSources =>
      _incomeSourceStorage.getIncomeSources();

  IncomeSourceNotifier get notifier => _incomeSourceNotifier;

  GlobalKey<SliverAnimatedListState> get key => _key;

  void addIncomeSources(IncomeSourceModel sourceModel) =>
      _incomeSourceNotifier.checkSource(sourceModel);

  Future<Resource<IncomeModel>> addIncome(
    String title,
    double amount, {
    String? desc,
    required List<IncomeSourceModel> sources,
  }) async {
    try {
      IncomeModel model = await _incomeClient.createIncome(title, amount,
          desc: desc, sources: sources);

      return Resource.data(data: model);
    } on DioError catch (dio) {
      return Resource.error(
          err: dio,
          errorMessage: dio.response?.statusMessage ?? "DIO ERROR OCCURED");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "UNKNOWN ERROR OCCURED");
    }
  }

  Future<Resource> deleteIncome(IncomeModel incomeModel) async {
    try {
      await _incomeClient.deleteIncome(incomeModel);
      _key.currentState?.removeItem(
        _incomes.indexOf(incomeModel),
        (context, animation) => FadeTransition(
          opacity: animation.drive<double>(opacity),
          child: SlideTransition(
            position: animation.drive<Offset>(offset),
            child: IncomeCard(income: incomeModel),
          ),
        ),
      );
      _storage.deleteIncomeModel(incomeModel);
      // _sources.remove(incomeSourceModel);
      return Resource.data(data: null, message: "REMOVED SUCCESSFULLY");
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.response?.statusMessage ?? "DIO ERROR OCCURED",
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "UNKNOWN ERROR OCCURED",
      );
    }
  }

  Future<void> getIncomes() async {
    emit(IncomeLoading());
    try {
      List<IncomeModel>? incomes = await _incomeClient.getIcomes();
      if (incomes != null) {
        await _storage.deleteIncomeModels();
        await _storage.addIncomes(incomes);
      }
      emit(IncomeLoadSuccess(data: _incomes, message: "Your Incomes"));
    } on DioError catch (dio) {
      emit(IncomeLoadFailed(
          errMessage: dio.response?.statusMessage ?? "Dio realted error",
          data: _incomes));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);

      emit(IncomeLoadFailed(
          errMessage: "Unknown errorr occured", data: _incomes));
    } finally {
      for (var element in _incomes) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => _key.currentState?.insertItem(_incomes.indexOf(element)),
        );
      }
    }
  }
}
