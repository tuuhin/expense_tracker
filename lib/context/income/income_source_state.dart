part of 'income_source_cubit.dart';

@immutable
abstract class IncomeSourceState {}

class IncomeStateSuccess<T> extends IncomeSourceState {
  final List<IncomeSourceModel>? data;
  final String? message;
  IncomeStateSuccess({this.data, this.message});
}

class IncomeStateFailed<T> extends IncomeSourceState {
  final String? message;
  IncomeStateFailed({this.message});
}

class IncomeStateLoading<T> extends IncomeSourceState {}
