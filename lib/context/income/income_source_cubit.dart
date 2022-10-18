import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/app/widgets/income/income_source_card.dart';
import 'package:expense_tracker/data/local/income/income_source_storage.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';

import '../../app/home/routes/route_builder.dart';
import '../../main.dart';

part 'income_source_state.dart';

class IncomeSourceCubit extends Cubit<IncomeSourceState> {
  IncomeSourceCubit() : super(IncomeStateLoading());

  final IncomeApi _clt = IncomeApi();

  static final IncomeSourceStorage _storage = IncomeSourceStorage();

  List<IncomeSourceModel> _sources = _storage.getIncomeSources();
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  bool isLoaded = false;

  GlobalKey<AnimatedListState> get incomeListKey => _key;
  List<IncomeSourceModel> get sources => _sources;

  Future<Resource> deleteIncomeSource(
      IncomeSourceModel incomeSourceModel) async {
    try {
      await _clt.deleteSource(incomeSourceModel);

      _key.currentState?.removeItem(
        _sources.indexOf(incomeSourceModel),
        (context, animation) => FadeTransition(
          opacity: animation.drive<double>(opacity),
          child: SlideTransition(
            position: animation.drive<Offset>(offset),
            child: IncomeSourceCard(source: incomeSourceModel),
          ),
        ),
      );

      _storage.deleteIncomeSource(incomeSourceModel);
      _sources.remove(incomeSourceModel);
      return Resource.data(data: null, message: "REMOVED SUCCESSFULLY");
    } on DioError catch (dio) {
      return Resource.error(
          err: dio,
          errorMessage: dio.response?.statusMessage ?? "DIO ERROR OCCURED");
    } catch (e) {
      return Resource.error(err: e, errorMessage: "UNKNOWN ERROR OCCURED");
    }
  }

  Future<Resource<IncomeSourceModel?>> addIncomeSource(String title,
      {String? desc, bool? isSecure}) async {
    try {
      IncomeSourceModel model =
          await _clt.createSource(title, desc: desc, isSecure: isSecure);
      _storage.addIncomeSource(model);
      _sources.add(model);
      _key.currentState?.insertItem(0);
      return Resource.data(data: model);
    } on DioError catch (dio) {
      return Resource.error(
          err: dio,
          errorMessage: dio.response?.statusMessage ?? "DIO ERROR OCCURED");
    } catch (e) {
      return Resource.error(err: e, errorMessage: "UNKNOWN ERROR OCCURED");
    }
  }

  void getIncomeSources() async {
    try {
      List<IncomeSourceModel>? modelsFromServer = await _clt.getSources();
      if (modelsFromServer != null) {
        logger.info('Invalidating cache for sources ');
        await _storage.deleteIncomeSources();
        await _storage.addIncomeSources(modelsFromServer);
      }
      _sources = _storage.getIncomeSources();
      emit(IncomeStateSuccess(data: _sources));

      for (var element in _sources) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => _key.currentState?.insertItem(_sources.indexOf(element)),
        );
      }
    } on DioError catch (dio) {
      emit(IncomeStateFailed(
          errMessage: dio.response?.statusMessage ?? "Dio realted error",
          data: _sources));
    } catch (e) {
      emit(IncomeStateFailed(
          errMessage: "Unknown errorr occured", data: _sources));
    }
  }
}
