import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'expense_model.freezed.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required int id,
    required String title,
    required double amount,
    required DateTime addedAt,
    required List<ExpenseCategoriesModel> categories,
    required BudgetModel budget,
    String? desc,
    String? imageURL,
  }) = _ExpenseModel;
}

@freezed
class CreateExpenseModel with _$CreateExpenseModel {
  factory CreateExpenseModel({
    required String title,
    required double amount,
    required int budgetId,
    required List<int> categoryIds,
    String? desc,
    String? path,
  }) = _CreateExpenseModel;
}
