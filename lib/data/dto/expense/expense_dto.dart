import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/domain/models/models.dart';

class ExpenseDto {
  final int id;
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<ExpenseCategoryDto>? categories;
  final BudgetDto budget;
  final String? desc;
  final String? imageURL;

  ExpenseDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    required this.budget,
    this.categories,
    this.desc,
    this.imageURL,
  });

  factory ExpenseDto.fromJson(Map<String, dynamic> json) {
    List categories = json['categories'] as List;

    return ExpenseDto(
      id: json['id'],
      title: json['title'],
      budget: BudgetDto.fromJson(json['budget']),
      amount: json['amount'],
      addedAt: DateTime.parse(json['added_at']),
      categories: categories
          .map((category) => ExpenseCategoryDto.fromJson(category))
          .toList(),
      desc: json['desc'],
      imageURL: json['receipt'],
    );
  }

  ExpenseModel toExpenseModel() => ExpenseModel(
        id: id,
        title: title,
        amount: amount,
        addedAt: addedAt,
        budget: budget.toModel(),
        desc: desc,
        imageURL: imageURL,
        categories: categories?.map((e) => e.toExpenseCategoryModel()).toList(),
      );

  ExpenseEntity toEntity() => ExpenseEntity(
        id: id,
        title: title,
        amount: amount,
        addedAt: addedAt,
        desc: desc,
        budget: budget.toEntity(),
        imageURL: imageURL,
        categories: categories?.map((e) => e.toEntity()).toList(),
      );

  factory ExpenseDto.fromEntity(ExpenseEntity entity) => ExpenseDto(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      addedAt: entity.addedAt,
      budget: BudgetDto.fromEntity(entity.budget),
      categories: entity.categories
          ?.map((e) => ExpenseCategoryDto.fromExpenseEntity(e))
          .toList(),
      desc: entity.desc,
      imageURL: entity.imageURL);

  factory ExpenseDto.fromExpenseModel(ExpenseModel expenseModel) => ExpenseDto(
      id: expenseModel.id,
      title: expenseModel.title,
      amount: expenseModel.amount,
      addedAt: expenseModel.addedAt,
      budget: BudgetDto.fromModel(expenseModel.budget),
      categories: expenseModel.categories
          ?.map((e) => ExpenseCategoryDto.fromExpenseCategoryModel(e))
          .toList(),
      desc: expenseModel.desc,
      imageURL: expenseModel.imageURL);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'amount': amount,
        'budget': budget,
        'categories': categories!.map((e) => e.toJson()),
        'imageURL': imageURL,
      };
}
