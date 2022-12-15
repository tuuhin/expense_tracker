part of 'entries_bloc.dart';

@freezed
class EntriesState with _$EntriesState {
  const factory EntriesState.loading() = _Loading;

  const factory EntriesState.data({required List<EntriesDataModel> data}) =
      _Data;
  const factory EntriesState.error({required String error}) = _Error;
  const factory EntriesState.loadMore({required List<EntriesDataModel> data}) =
      _MoreData;

  const factory EntriesState.noData({required String message}) = _Nodata;

  const factory EntriesState.errorLoadMore(
      {required List<EntriesDataModel> data,
      required String error}) = _ErrorOnMore;

  const factory EntriesState.end(
      {required List<EntriesDataModel> data, required String message}) = _End;
}
