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
  final String? message;
  ExpenseCategoryStateFailed({this.data, this.message});
}

class ExpenseCategoryStateLoading extends ExpenseCategoryState {}
