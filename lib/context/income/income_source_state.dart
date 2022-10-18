part of 'income_source_cubit.dart';

@immutable
abstract class IncomeSourceState {}

class IncomeStateSuccess extends IncomeSourceState {
  final List<IncomeSourceModel>? data;
  final String? message;
  IncomeStateSuccess({this.data, this.message});
}

class IncomeStateFailed extends IncomeSourceState {
  final String errMessage;
  final List<IncomeSourceModel>? data;
  final StackTrace? stk;

  IncomeStateFailed({required this.errMessage, this.data, this.stk});
}

class IncomeStateLoading extends IncomeSourceState {}
