part of 'entries_bloc.dart';

@freezed
class EntriesState with _$EntriesState {
  const factory EntriesState.loading() = _Loading;

  const factory EntriesState.data(List<EntriesDataModel> data) = _Data;
  const factory EntriesState.error(String error) = _StateError;
  const factory EntriesState.loadMore(List<EntriesDataModel> data) = _MoreData;

  const factory EntriesState.errorLoadMore(
      List<EntriesDataModel> data, String error) = _ErrorLoadMore;

  const factory EntriesState.end(List<EntriesDataModel> data, String message) =
      _End;
}
