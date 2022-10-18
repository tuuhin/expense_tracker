import 'package:expense_tracker/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required int id,
    required String title,
    required double amount,
    required DateTime addedAt,
    List<ExpenseCategoriesModel>? categories,
    required BudgetModel budget,
    String? desc,
    String? imageURL,
  }) = _ExpenseModel;
}
