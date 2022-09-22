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

      if (_key.currentState != null) {
        _key.currentState!.removeItem(
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
      }

      return ResourceSucess(message: 'Successfully removed source');
    } on DioError catch (dio) {
      return ResourceFailed(message: dio.message);
    } catch (e) {
      return ResourceFailed(message: e.toString());
    }
  }

  Future<Resource<IncomeSourceModel?>> addIncomeSource(String title,
      {String? desc, bool? isSecure}) async {
    try {
      IncomeSourceModel? model =
          await _clt.createSource(title, desc: desc, isSecure: isSecure);
      if (_key.currentState != null && model != null) {
        _storage.addIncomeSource(model);
        _sources.add(model);
        _key.currentState!.insertItem(_sources.length - 1);
      }
      return ResourceSucess(data: model);
    } on DioError catch (dio) {
      return ResourceFailed(message: dio.message);
    } catch (e) {
      return ResourceFailed(message: e.toString());
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
      Future future = Future(() {});
      for (var element in _sources) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(_sources.indexOf(element));
              }
            },
          ),
        );
      }
    } on DioError catch (dio) {
      emit(IncomeStateFailed(message: dio.message));
    } catch (e) {
      emit(IncomeStateFailed(message: e.toString()));
    }
  }
}
