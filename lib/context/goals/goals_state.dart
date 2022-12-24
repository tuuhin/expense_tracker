part of 'goals_bloc.dart';

@freezed
class GoalsState with _$GoalsState {
  factory GoalsState.loading() = _Loading;

  factory GoalsState.data({
    required List<GoalsModel> data,
    String? message,
  }) = _Data;

  factory GoalsState.error({
    required Object error,
    required String message,
  }) = _Error;

  factory GoalsState.errorWithData({
    required Object error,
    required String message,
    required List<GoalsModel> data,
  }) = _ErrorWithData;

  factory GoalsState.noData({required String message}) = _NoData;
}
