import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/domain/models/models.dart';

class ExpenseDto {
  final int id;
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<ExpenseCategoryDto>? categories;
  final String? desc;
  final String? imageURL;

  ExpenseDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    this.categories,
    this.desc,
    this.imageURL,
  });

  factory ExpenseDto.fromJson(Map<String, dynamic> json) {
    List categories = json['categories'] as List;
    return ExpenseDto(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      addedAt: DateTime.parse(json['addedAt']),
      categories: categories
          .map((category) => ExpenseCategoryDto.fromJson(category))
          .toList(),
      desc: json['desc'],
      imageURL: json['recepit'],
    );
  }

  ExpenseModel toExpenseModel() => ExpenseModel(
        id: id,
        title: title,
        amount: amount,
        addedAt: addedAt,
        desc: desc,
        imageURL: imageURL,
        categories: categories?.map((e) => e.toExpenseCategoryModel()).toList(),
      );

  factory ExpenseDto.fromExpenseModel(ExpenseModel expenseModel) => ExpenseDto(
        id: expenseModel.id,
        title: expenseModel.title,
        amount: expenseModel.amount,
        addedAt: expenseModel.addedAt,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'amount': amount,
        'categories': categories!.map((e) => e.toJson()),
        'imageURL': imageURL
      };
}
