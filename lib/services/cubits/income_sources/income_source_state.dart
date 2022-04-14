part of 'income_source_cubit.dart';

@immutable
abstract class IncomeSourceState {}

class IncomeSourceLoaded extends IncomeSourceState {
  final List<IncomeSourceModel?> models;

  IncomeSourceLoaded({required this.models});
}

class IncomeSourceLoadFailed extends IncomeSourceState {}

class IncomeSourceLoad extends IncomeSourceState {}
