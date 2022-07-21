part of 'income_cubit.dart';

@immutable
abstract class IncomeState {}

class IncomeLoading extends IncomeState {}

class IncomeLoadSuccess extends IncomeState {
  final List<IncomeModel>? data;
  final String? message;
  IncomeLoadSuccess({this.data, this.message});
}

class IncomeLoadFailed extends IncomeState {
  final String? message;
  IncomeLoadFailed({this.message});
}
