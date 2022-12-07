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
  final DateTime start;
  @JsonKey(name: "to")
  final DateTime end;
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
    required this.start,
    required this.end,
    required this.amount,
    required this.amountUsed,
    required this.issedAt,
    required this.hasExpired,
  });

  factory BudgetDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetDtoToJson(this);

  factory BudgetDto.fromModel(BudgetModel model) => BudgetDto(
        id: model.id,
        title: model.title,
        desc: model.desc,
        start: model.start,
        end: model.end,
        amount: model.amount,
        amountUsed: model.amountUsed,
        issedAt: model.issedAt,
        hasExpired: model.hasExpired,
      );

  factory BudgetDto.fromEntity(BudgetEntity entity) => BudgetDto(
        id: entity.id,
        title: entity.title,
        desc: entity.desc,
        start: entity.statedFrom,
        end: entity.tillDate,
        amount: entity.amount,
        amountUsed: entity.amountUsed,
        issedAt: entity.issedAt,
        hasExpired: entity.hasExpired,
      );

  BudgetModel toModel() => BudgetModel(
        id: id,
        title: title,
        desc: desc,
        start: start,
        end: end,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );

  BudgetEntity toEntity() => BudgetEntity(
        id: id,
        title: title,
        desc: desc,
        statedFrom: start,
        tillDate: end,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );
}
