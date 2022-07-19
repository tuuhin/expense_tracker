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
  final List<ExpenseCategoriesEntity>? categories;

  @HiveField(5)
  final String? desc;

  @HiveField(6)
  final String? imageURL;

  ExpenseEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    this.categories,
    this.desc,
    this.imageURL,
  });
}
