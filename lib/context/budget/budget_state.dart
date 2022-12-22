part of 'budget_cubit.dart';

@freezed
class BudgetState with _$BudgetState {
  factory BudgetState.loading() = _Loading;

  factory BudgetState.data({
    required List<BudgetModel> data,
    String? message,
  }) = _Data;

  factory BudgetState.error({
    required Object error,
    required String message,
  }) = _Error;

  factory BudgetState.errorWithData({
    required Object error,
    required String message,
    required List<BudgetModel> data,
  }) = _ErrorWithData;

  factory BudgetState.noData({required String message}) = _NoData;
}
