import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_expense_dto.g.dart';

@JsonSerializable()
class CreateExpenseDto {
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "budget")
  final int budgetId;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "categories")
  final List<int> categoryIds;
  @JsonKey(name: "receipt")
  final String? image;

  CreateExpenseDto({
    required this.title,
    required this.amount,
    required this.budgetId,
    required this.categoryIds,
    this.desc,
    this.image,
  });

  factory CreateExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseDtoFromJson(json);

  factory CreateExpenseDto.fromModel(CreateExpenseModel expense) =>
      CreateExpenseDto(
        title: expense.title,
        amount: expense.amount,
        budgetId: expense.budgetId,
        categoryIds: expense.categories.map((e) => e.id).toList(),
        desc: expense.desc,
        image: expense.path,
      );

  Map<String, dynamic> toJson() => _$CreateExpenseDtoToJson(this);
}
