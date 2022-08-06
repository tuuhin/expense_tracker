import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/remote/entries_api.dart';
import 'package:expense_tracker/domain/models/entries_information_model.dart';
import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  EntriesCubit() : super(EntriesLoad());
  final EntriesApi _clt = EntriesApi();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  String? _nextURL;

  GlobalKey<AnimatedListState> get entriesKey => _key;

  String? get nextURL => _nextURL;

  final List<EntriesModel> _models = [];

  Future<void> getMoreEntries(String nextURL) async {
    logger.fine('get more ');
    try {
      Map<String, String> queryParams = Uri.parse(nextURL).queryParameters;

      EntriesInfomationModel entriesInfomationModel =
          await _clt.getMoreEntries(queryParams);

      _nextURL = entriesInfomationModel.nextURL;

      List<EntriesModel> newModels = entriesInfomationModel.entries;

      _models.addAll(newModels);

      emit(EntriesLoadSuccess(data: _models));

      Future future = Future(() {});
      for (var element in newModels) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState == null) return;
              _key.currentState!.insertItem(_models.indexOf(element));
            },
          ),
        );
      }
    } catch (e) {
      logger.shout(e);
    }
  }

  Future<void> getEntires() async {
    // emit(EntriesLoad());
    try {
      if (_models.isNotEmpty) {
        _models.clear();
      }
      EntriesInfomationModel entriesInfomationModel = await _clt.getEntries();
      _nextURL = entriesInfomationModel.nextURL;
      _models.addAll(entriesInfomationModel.entries);
      emit(EntriesLoadSuccess(data: _models));
      Future future = Future(() {});
      for (var element in _models) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState == null) return;
              _key.currentState!.insertItem(_models.indexOf(element));
            },
          ),
        );
      }
    } catch (e) {
      logger.info(e);
    }
  }
}
