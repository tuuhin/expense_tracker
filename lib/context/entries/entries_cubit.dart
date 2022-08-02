import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/remote/entries_api.dart';
import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  EntriesCubit() : super(EntriesLoad());
  final EntriesApi _clt = EntriesApi();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  // List<EntriesModel> _models = [];

  GlobalKey<AnimatedListState> get entriesKey => _key;
  // List<EntriesModel> get entriesModel => _models;

  Future<void> getEntires() async {
    emit(EntriesLoad());
    try {
      List<EntriesModel> entries = await _clt.getEntries();

      emit(EntriesLoadSuccess(data: entries));
      Future future = Future(() {});
      for (var element in entries) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(entries.indexOf(element));
              }
            },
          ),
        );
      }
    } catch (e) {
      logger.info(e);
    }
  }

  void loadMoreEntries(Map<String, dynamic> query) async {
    try {
      List<EntriesModel> entries = await _clt.getMoreEntries(query);
      emit(EntriesLoadSuccess(data: entries));
      Future future = Future(() {});
      for (var element in entries) {
        future = future.then(
          (value) => Future.delayed(
            const Duration(milliseconds: 50),
            () {
              if (_key.currentState != null) {
                _key.currentState!.insertItem(entries.indexOf(element));
              }
            },
          ),
        );
      }
    } catch (e) {
      logger.info(e);
    }
  }
}
