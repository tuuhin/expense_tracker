import 'package:expense_tracker/domain/models/expense/expense_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_expense_dto.g.dart';

@JsonSerializable()
class UpdateExpenseDto {
  @JsonKey(name: "id")
  final int id;
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

  UpdateExpenseDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.budgetId,
    required this.categoryIds,
    this.desc,
    this.image,
  });

  Map<String, dynamic> toJson() => _$UpdateExpenseDtoToJson(this);

  factory UpdateExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateExpenseDtoFromJson(json);

  factory UpdateExpenseDto.fromModel(UpdateExpenseModel model) =>
      UpdateExpenseDto(
        id: model.id,
        title: model.title,
        amount: model.amount,
        budgetId: model.budget.id,
        categoryIds: model.categories.map((e) => e.id).toList(),
      );
}
