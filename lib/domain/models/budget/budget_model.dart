import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';

@freezed
class BaseBudgetModel with _$BaseBudgetModel {
  factory BaseBudgetModel({
    required int id,
    required String title,
    String? desc,
    required DateTime start,
    required DateTime end,
    required double amount,
  }) = _BaseBudgetModel;
}

@freezed
class BudgetModel with _$BudgetModel {
  const BudgetModel._();
  factory BudgetModel({
    required int id,
    required String title,
    String? desc,
    double? amountLeft,
    required DateTime start,
    required DateTime end,
    required double amount,
    required double amountUsed,
    required DateTime issedAt,
    required bool hasExpired,
  }) = _BudgetModel;

  BaseBudgetModel toBaseModel() => BaseBudgetModel(
      id: id, title: title, start: start, end: end, amount: amount);
}

@freezed
class CreateBudgetModel with _$CreateBudgetModel {
  factory CreateBudgetModel({
    required String title,
    String? desc,
    required DateTime start,
    required DateTime end,
    required double amount,
  }) = _CreateBudgetModel;
}
