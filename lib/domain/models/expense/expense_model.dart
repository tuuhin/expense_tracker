import 'package:expense_tracker/domain/models/models.dart';

class ExpenseModel {
  final int id;
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<ExpenseCategoriesModel>? categories;
  final String? desc;
  final String? imageURL;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    this.categories,
    this.desc,
    this.imageURL,
  });
}
