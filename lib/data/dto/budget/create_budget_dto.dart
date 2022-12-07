import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_budget_dto.g.dart';

@JsonSerializable()
class CreateBudgetDto {
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

  CreateBudgetDto({
    required this.title,
    this.desc,
    required this.start,
    required this.end,
    required this.amount,
  });

  factory CreateBudgetDto.fromJson(Map<String, dynamic> json) =>
      _$CreateBudgetDtoFromJson(json);

  factory CreateBudgetDto.fromModel(CreateBudgetModel budget) =>
      CreateBudgetDto(
        title: budget.title,
        desc: budget.desc,
        start: budget.start,
        end: budget.end,
        amount: budget.amount,
      );

  Map<String, dynamic> toJson() => _$CreateBudgetDtoToJson(this);

  CreateBudgetModel toModel() => CreateBudgetModel(
      title: title, desc: desc, start: start, end: end, amount: amount);
}
