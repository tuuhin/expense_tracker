part of 'income_source_cubit.dart';

@immutable
abstract class IncomeSourceState {}

class IncomeSourcesLoadSuccess extends IncomeSourceState {
  final List<IncomeSourceModel> data;
  final String? message;
  IncomeSourcesLoadSuccess({required this.data, this.message});
}

class IncomeSourcesLoadFailed extends IncomeSourceState {
  final String errMessage;
  final List<IncomeSourceModel>? data;
  final StackTrace? stk;

  IncomeSourcesLoadFailed({required this.errMessage, this.data, this.stk});
}

class IncomeSourcesLoading extends IncomeSourceState {}
