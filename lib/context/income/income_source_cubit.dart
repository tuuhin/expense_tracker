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
  IncomeSourceCubit() : super(IncomeSourcesLoading());

  final IncomeApi _clt = IncomeApi();

  final IncomeSourceStorage _storage = IncomeSourceStorage();

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();
  List<IncomeSourceModel> get _sources => _storage.getIncomeSources();

  GlobalKey<SliverAnimatedListState> get incomeListKey => _key;
  // List<IncomeSourceModel> get sources => _sources;

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

  Future<Resource<IncomeSourceModel>> addIncomeSource(String title,
      {String? desc, bool? isSecure}) async {
    try {
      IncomeSourceModel model =
          await _clt.createSource(title, desc: desc, isSecure: isSecure);
      _storage.addIncomeSource(model);
      // _sources.add(model);
      List<IncomeSourceModel> sources = _sources;
      emit(IncomeSourcesLoadSuccess(data: sources));
      _key.currentState?.insertItem(sources.length - 1);
      return Resource.data(data: model);
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

  Future<void> getIncomeSources() async {
    emit(IncomeSourcesLoading());
    try {
      List<IncomeSourceModel>? modelsFromServer = await _clt.getSources();
      if (modelsFromServer != null) {
        logger.info('Invalidating cache for sources ');
        await _storage.deleteIncomeSources();
        await _storage.addIncomeSources(modelsFromServer);
      }
      emit(IncomeSourcesLoadSuccess(data: _sources));
    } on DioError catch (dio) {
      emit(IncomeSourcesLoadFailed(
          errMessage: dio.response?.statusMessage ?? "Dio realted error",
          data: _sources));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      emit(IncomeSourcesLoadFailed(
          errMessage: "Unknown errorr occured", data: _sources));
    }
    for (final IncomeSourceModel src in _sources) {
      await Future.delayed(
        const Duration(milliseconds: 50),
        () => _key.currentState?.insertItem(_sources.indexOf(src)),
      );
    }
  }
}
