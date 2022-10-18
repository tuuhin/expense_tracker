part of 'expense_categories_cubit.dart';

@immutable
abstract class ExpenseCategoryState {}

class ExpenseCategoryStateSuccess extends ExpenseCategoryState {
  final List<ExpenseCategoriesModel?>? data;
  final String? message;
  ExpenseCategoryStateSuccess({this.data, this.message});
}

class ExpenseCategoryStateFailed extends ExpenseCategoryState {
  final List<ExpenseCategoriesModel?>? data;
  final String errMessage;
  final StackTrace? stackTrace;
  ExpenseCategoryStateFailed({
    required this.errMessage,
    this.data,
    this.stackTrace,
  });
}

class ExpenseCategoryStateLoading extends ExpenseCategoryState {}
