import 'package:freezed_annotation/freezed_annotation.dart';
part 'expense_categories_model.freezed.dart';
part 'expense_categories_model.g.dart';

@Freezed()
class ExpenseCategoriesModel with _$ExpenseCategoriesModel {
  const factory ExpenseCategoriesModel({
    required int id,
    required String title,
    String? desc,
  }) = _ExpenseCategoriesModel;

  factory ExpenseCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoriesModelFromJson(json);
}
