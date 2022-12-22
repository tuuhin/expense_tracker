import 'package:hive/hive.dart';
part 'budget_entity.g.dart';

@HiveType(typeId: 07)
class BudgetEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? desc;

  @HiveField(3)
  final DateTime statedFrom;

  @HiveField(4)
  final DateTime tillDate;

  @HiveField(5)
  final double amount;

  @HiveField(6)
  final double amountUsed;

  @HiveField(7)
  final DateTime issedAt;

  @HiveField(8)
  final bool hasExpired;

  @HiveField(9)
  final double? amountLeft;

  BudgetEntity({
    required this.id,
    required this.title,
    this.desc,
    this.amountLeft,
    required this.statedFrom,
    required this.tillDate,
    required this.amount,
    required this.amountUsed,
    required this.issedAt,
    required this.hasExpired,
  });
}
