import 'package:json_annotation/json_annotation.dart';

part 'expense_categories_model.g.dart';

@JsonSerializable()
class ExpenseCategoriesModel {
  final int id;
  final String title;
  final String? desc;
  ExpenseCategoriesModel({
    required this.id,
    required this.title,
    this.desc,
  });

  factory ExpenseCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoriesModelToJson(this);
}
