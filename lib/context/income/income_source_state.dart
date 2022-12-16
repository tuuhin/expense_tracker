part of 'income_source_cubit.dart';

@freezed
class IncomeSourceState with _$IncomeSourceState {
  factory IncomeSourceState.loading() = _Loading;

  factory IncomeSourceState.data(
      {required List<IncomeSourceModel> data, String? message}) = _Success;

  factory IncomeSourceState.error(
      {required String errMessage, required Object err}) = _Error;

  factory IncomeSourceState.noData({String? message}) = _NoData;

  factory IncomeSourceState.errorWithData({
    required String errMessage,
    required Object err,
    required List<IncomeSourceModel> data,
  }) = _ErrorWithData;
}
