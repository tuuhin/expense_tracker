import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_categories_model.freezed.dart';

@freezed
class ExpenseCategoriesModel with _$ExpenseCategoriesModel {
  const factory ExpenseCategoriesModel({
    required int id,
    required String title,
    String? desc,
  }) = _ExpenseCategoriesModel;

  @override
  String toString() {
    return "$id: $title";
  }
}

@freezed
class CreateCategoryModel with _$CreateCategoryModel {
  factory CreateCategoryModel({
    required String title,
    String? desc,
  }) = _CreateCategoryModel;
}
