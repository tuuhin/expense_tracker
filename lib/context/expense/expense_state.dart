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
  final List<ExpenseModel>? data;
  final String errMessage;
  final StackTrace? stackTrace;
  ExpenseLoadFailed({this.data, this.stackTrace, required this.errMessage});
}
