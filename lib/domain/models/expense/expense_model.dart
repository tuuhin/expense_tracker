import 'package:expense_tracker/domain/models/models.dart';

class ExpenseModel {
  final int id;
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<ExpenseCategoriesModel>? categories;
  final String? desc;
  final String? imageURL;

  ExpenseModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.addedAt,
      this.categories,
      this.desc,
      this.imageURL});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      addedAt: DateTime.parse(json['added_at']),
      amount: json['amount'],
      imageURL: json['imageURL']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'amount': amount,
        'desc': desc,
      };
}
