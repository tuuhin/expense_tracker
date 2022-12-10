import 'package:expense_tracker/data/entity/entity.dart';
import 'package:hive/hive.dart';

part 'expense_entity.g.dart';

@HiveType(typeId: 04)
class ExpenseEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime addedAt;

  @HiveField(4)
  final List<CategoryEntity> categories;

  @HiveField(5)
  final BudgetEntity budget;

  @HiveField(6)
  final String? desc;

  @HiveField(7)
  final String? imageURL;

  ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    required this.categories,
    required this.budget,
    this.desc,
    this.imageURL,
  });
}
