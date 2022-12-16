part of 'income_cubit.dart';

@freezed
class IncomeState with _$IncomeState {
  factory IncomeState.loading() = _Loading;

  factory IncomeState.data({required List<IncomeModel> data, String? message}) =
      _Data;

  factory IncomeState.error({required String errMessage, required Object err}) =
      _Error;

  factory IncomeState.errorWithData({
    required String errMessage,
    required Object err,
    required List<IncomeModel> data,
  }) = _ErrorWithData;

  factory IncomeState.noData({required String message}) = _NoData;
}
