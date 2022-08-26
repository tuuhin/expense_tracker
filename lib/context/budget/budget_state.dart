part of 'budget_cubit.dart';

@immutable
abstract class BudgetState {}

class BudgetLoad extends BudgetState {}

class BudgetLoadSuccess extends BudgetState {
  final List<BudgetModel> data;
  final String? message;
  BudgetLoadSuccess({required this.data, this.message});
}

class BudgetLoadFailed extends BudgetState {
  final String? message;
  BudgetLoadFailed({this.message});
}
