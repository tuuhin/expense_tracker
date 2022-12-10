part of 'expense_categories_cubit.dart';

@freezed
class ExpenseCategoryState with _$ExpenseCategoryState {
  factory ExpenseCategoryState.loading() = _Loading;

  factory ExpenseCategoryState.data(
      {required List<ExpenseCategoriesModel> data, String? message}) = _Success;

  factory ExpenseCategoryState.error(
      {required String errMessage, required Object err}) = _Error;

  factory ExpenseCategoryState.noData({String? message}) = _NoData;

  factory ExpenseCategoryState.errorWithData(
      {required String errMessage,
      required Object err,
      required List<ExpenseCategoriesModel> data}) = _ErrorWithData;
}
