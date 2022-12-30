import 'package:hive/hive.dart';

part 'user_base_data_entity.g.dart';

@HiveType(typeId: 8)
class UserBaseDataEntity extends HiveObject {
  @HiveField(0)
  final double totalIncome;

  @HiveField(1)
  final double monthlyIncome;

  @HiveField(2)
  final double totalExpense;

  @HiveField(3)
  final double monthlyExpense;

  UserBaseDataEntity({
    required this.monthlyExpense,
    required this.totalExpense,
    required this.monthlyIncome,
    required this.totalIncome,
  });
}
