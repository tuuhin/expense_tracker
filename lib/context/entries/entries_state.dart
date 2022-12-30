part of 'entries_bloc.dart';

@freezed
class EntriesState with _$EntriesState {
  factory EntriesState.loading() = _Loading;

  factory EntriesState.data({required List<EntriesDataModel> data}) = _Data;
  factory EntriesState.error({required String error}) = _Error;
  factory EntriesState.loadMore({required List<EntriesDataModel> data}) =
      _MoreData;

  factory EntriesState.noData({required String message}) = _Nodata;

  factory EntriesState.errorLoadMore(
      {required List<EntriesDataModel> data,
      required String error}) = _ErrorOnMore;

  factory EntriesState.end(
      {required List<EntriesDataModel> data, required String message}) = _End;
}
