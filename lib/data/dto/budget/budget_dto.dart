import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/budget/budget_model.dart';
import '../../entity/entity.dart';

part 'budget_dto.g.dart';

@JsonSerializable()
class BudgetDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "_from")
  final DateTime statedFrom;
  @JsonKey(name: "to")
  final DateTime tillDate;
  @JsonKey(name: "total_amount")
  final double amount;
  @JsonKey(name: "amount_used")
  final double amountUsed;
  @JsonKey(name: "issued_at")
  final DateTime issedAt;
  @JsonKey(name: "has_expired")
  final bool hasExpired;

  BudgetDto({
    required this.id,
    required this.title,
    this.desc,
    required this.statedFrom,
    required this.tillDate,
    required this.amount,
    required this.amountUsed,
    required this.issedAt,
    required this.hasExpired,
  });

  factory BudgetDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetDtoToJson(this);

  factory BudgetDto.fromModel(BudgetModel budgetModel) => BudgetDto(
        id: budgetModel.id,
        title: budgetModel.title,
        desc: budgetModel.desc,
        statedFrom: budgetModel.statedFrom,
        tillDate: budgetModel.tillDate,
        amount: budgetModel.amount,
        amountUsed: budgetModel.amountUsed,
        issedAt: budgetModel.issedAt,
        hasExpired: budgetModel.hasExpired,
      );

  factory BudgetDto.fromEntity(BudgetEntity budgetEntity) => BudgetDto(
        id: budgetEntity.id,
        title: budgetEntity.title,
        desc: budgetEntity.desc,
        statedFrom: budgetEntity.statedFrom,
        tillDate: budgetEntity.tillDate,
        amount: budgetEntity.amount,
        amountUsed: budgetEntity.amountUsed,
        issedAt: budgetEntity.issedAt,
        hasExpired: budgetEntity.hasExpired,
      );

  BudgetModel toModel() => BudgetModel(
        id: id,
        title: title,
        desc: desc,
        statedFrom: statedFrom,
        tillDate: tillDate,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );

  BudgetEntity toEntity() => BudgetEntity(
        id: id,
        title: title,
        desc: desc,
        statedFrom: statedFrom,
        tillDate: tillDate,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );
}
