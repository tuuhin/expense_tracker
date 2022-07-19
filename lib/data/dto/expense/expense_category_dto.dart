import 'package:expense_tracker/domain/models/models.dart';

import '../../entity/expense/expense_categories_entity.dart';

class ExpenseCategoryDto {
  final int id;
  final String title;
  final String? desc;
  ExpenseCategoryDto({
    required this.id,
    required this.title,
    this.desc,
  });

  factory ExpenseCategoryDto.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryDto(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
      );

  ExpenseCategoriesEntity toEntity() =>
      ExpenseCategoriesEntity(id: id, title: title, desc: desc);

  ExpenseCategoriesModel toExpenseCategoryModel() =>
      ExpenseCategoriesModel(id: id, title: title, desc: desc);

  factory ExpenseCategoryDto.fromExpenseEntity(
          ExpenseCategoriesEntity entity) =>
      ExpenseCategoryDto(
        id: entity.id,
        title: entity.title,
        desc: entity.desc,
      );

  factory ExpenseCategoryDto.fromExpenseCategoryModel(
          ExpenseCategoriesModel categoriesModel) =>
      ExpenseCategoryDto(
          id: categoriesModel.id,
          title: categoriesModel.title,
          desc: categoriesModel.desc);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
      };
}
