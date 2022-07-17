import 'package:expense_tracker/domain/models/models.dart';

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

  ExpenseCategoriesModel toExpenseCategoryModel() =>
      ExpenseCategoriesModel(id: id, title: title, desc: desc);

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
