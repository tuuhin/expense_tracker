import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';

@freezed
class BudgetModel with _$BudgetModel {
  factory BudgetModel({
    required int id,
    required String title,
    String? desc,
    required DateTime start,
    required DateTime end,
    required double amount,
    required double amountUsed,
    required DateTime issedAt,
    required bool hasExpired,
  }) = _BudgetModel;
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
