part of 'expense_cubit.dart';

@immutable
abstract class ExpenseState {}

class ExpensesLoading extends ExpenseState {}

class ExpenseLoadSuccess extends ExpenseState {
  final List<ExpenseModel>? data;
  final String? message;
  ExpenseLoadSuccess({this.data, this.message});
}

class ExpenseLoadFailed extends ExpenseState {
  final String? message;
  ExpenseLoadFailed({this.message});
}
