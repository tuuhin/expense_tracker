import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/remote/base_data_client.dart';
import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:flutter/foundation.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  EntriesCubit() : super(EntriesLoad());
  final BaseDataClient _clt = BaseDataClient();

  void emitLoadState() => emit(EntriesLoad());

  Future<void> loadEntriesByURL(String? url) async {
    emit(EntriesLoad());
    Map? _data = await _clt.getEntriesByUrl(url);
    if (_data != null) {
      final List results = _data['results'] as List;
      final int? highestCount = _data['highest_count'];
      final int? overallCount = _data['overall_total'];
      final String? nextURL = _data['next'];
      final String? previousURL = _data['previous'];
      List<EntriesModel> _entries =
          results.map((json) => EntriesModel.fromJson(json)).toList();

      emit(EntriesLoadSuccess(
          entries: _entries,
          nextURL: nextURL,
          previousURL: previousURL,
          highestCount: highestCount,
          overallCount: overallCount));
    } else {
      emit(EntriesLoadFailed());
    }
  }

  void loadEntries() async {
    Map? _data = await _clt.getEntries();
    if (_data != null) {
      final List results = _data['results'] as List;
      print(_data);
      final int? highestCount = _data['highest_count'];
      final int? overallCount = _data['overall_total'];
      final String? nextURL = _data['next'];
      final String? previousURL = _data['previous'];
      List<EntriesModel> _entries =
          results.map((json) => EntriesModel.fromJson(json)).toList();

      emit(EntriesLoadSuccess(
          entries: _entries,
          nextURL: nextURL,
          previousURL: previousURL,
          highestCount: highestCount,
          overallCount: overallCount));
    } else {
      emit(EntriesLoadFailed());
    }
  }
}
