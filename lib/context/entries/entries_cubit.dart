import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/remote/entries_api.dart';
import '../../domain/models/entries_information_model.dart';
import '../../domain/models/models.dart';
import '../../main.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  EntriesCubit() : super(EntriesLoad());

  final EntriesApi _clt = EntriesApi();

  final GlobalKey<SliverAnimatedListState> _key =
      GlobalKey<SliverAnimatedListState>();

  String? _nextURL;

  GlobalKey<SliverAnimatedListState> get entriesKey => _key;

  final List<EntriesModel> _models = [];

  Timer _timer = Timer(const Duration(milliseconds: 2000), () {});

  void loadMore() => _getMoreEntries();

  Future<void> _getMoreEntries() async {
    if (_nextURL == null) {
      emit(EntriesLoadedAll(data: _models, message: "No more Entries to load"));
      return;
    }
    if (_timer.isActive) return;
    _timer = Timer(const Duration(milliseconds: 2000), () {});
    logger.fine('get more ');
    try {
      emit(EntriesLoadMore(data: _models));
      Map<String, String> queryParams = Uri.parse(_nextURL!).queryParameters;

      EntriesInfomationModel entries = await _clt.getMoreEntries(queryParams);

      _nextURL = entries.nextURL;

      List<EntriesModel> newModels = entries.entries;

      _models.addAll(newModels);

      emit(EntriesLoadSuccess(data: _models));

      for (final EntriesModel etry in newModels) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => _key.currentState?.insertItem(_models.indexOf(etry)),
        );
      }
    } on DioError catch (err) {
      emit(EntriesLoadMoreFailed(data: _models, errMessage: err.message));
    } catch (e) {
      logger.shout(e);
      emit(EntriesLoadMoreFailed(data: _models, errMessage: "error occured"));
    }
  }

  Future<void> getEntires() async {
    emit(EntriesLoad());
    try {
      if (_models.isNotEmpty) _models.clear();

      EntriesInfomationModel entries = await _clt.getEntries();
      _nextURL = entries.nextURL;
      _models.addAll(entries.entries);
      emit(EntriesLoadSuccess(data: _models));

      for (final EntriesModel etry in _models) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => _key.currentState?.insertItem(
            _models.indexOf(etry),
          ),
        );
      }
    } on DioError catch (err) {
      emit(EntriesLoadFailed(errMessage: err.message));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      logger.info(e);
      emit(EntriesLoadFailed(errMessage: e.runtimeType.toString()));
    }
  }
}
