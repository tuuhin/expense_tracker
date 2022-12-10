import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/models.dart';
import '../../entity/entity.dart';
import '../dto.dart';

part 'expense_dto.g.dart';

@JsonSerializable()
class ExpenseDto {
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "added_at")
  final DateTime addedAt;
  @JsonKey(name: "categories")
  final List<ExpenseCategoryDto> categories;
  @JsonKey(name: "budget")
  final BudgetDto budget;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "receipt")
  String? receipt;

  ExpenseDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    required this.budget,
    required this.categories,
    this.desc,
    this.receipt,
  });

  factory ExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDtoToJson(this);

  ExpenseModel toModel() => ExpenseModel(
        id: id,
        title: title,
        amount: amount,
        addedAt: addedAt,
        budget: budget.toModel(),
        desc: desc,
        imageURL: receipt,
        categories: categories.map((e) => e.toModel()).toList(),
      );

  ExpenseEntity toEntity() => ExpenseEntity(
        id: id,
        title: title,
        amount: amount,
        addedAt: addedAt,
        desc: desc,
        budget: budget.toEntity(),
        imageURL: receipt,
        categories: categories.map((e) => e.toEntity()).toList(),
      );

  factory ExpenseDto.fromEntity(ExpenseEntity entity) => ExpenseDto(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      addedAt: entity.addedAt,
      budget: BudgetDto.fromEntity(entity.budget),
      categories: entity.categories
          .map((e) => ExpenseCategoryDto.fromEntity(e))
          .toList(),
      desc: entity.desc,
      receipt: entity.imageURL);

  factory ExpenseDto.fromModel(ExpenseModel model) => ExpenseDto(
      id: model.id,
      title: model.title,
      amount: model.amount,
      addedAt: model.addedAt,
      budget: BudgetDto.fromModel(model.budget),
      categories:
          model.categories.map((e) => ExpenseCategoryDto.fromModel(e)).toList(),
      desc: model.desc,
      receipt: model.imageURL);
}
