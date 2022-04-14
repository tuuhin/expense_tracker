part of 'expense_categories_cubit.dart';

@immutable
abstract class ExpenseCategoriesState {}

class ExpenseCategoriesLoad extends ExpenseCategoriesState {}

class ExpenseCategoriesLoadSuccess extends ExpenseCategoriesState {
  final List<ExpenseCategoriesModel?> models;

  ExpenseCategoriesLoadSuccess({required this.models});
}

class ExpenseCategoriesLoadFailed extends ExpenseCategoriesState {}
