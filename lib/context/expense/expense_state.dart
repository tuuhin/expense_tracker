part of 'expense_cubit.dart';

@freezed
class ExpenseState with _$ExpenseState {
  factory ExpenseState.loading() = _Loading;
  factory ExpenseState.data(
      {required List<ExpenseModel> data, String? message}) = _Data;

  factory ExpenseState.error(
      {required String errMessage, required Object err}) = _Error;

  factory ExpenseState.noData({String? message}) = _NoData;

  factory ExpenseState.errorWithData({
    required List<ExpenseModel> data,
    required String errMessage,
    required Object err,
  }) = _ErrorWithData;
}
