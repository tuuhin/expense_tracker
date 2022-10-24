import 'package:hive/hive.dart';

import '../../../domain/models/user/user_base_overview_model.dart';

part 'user_base_data_entity.g.dart';

@HiveType(typeId: 08)
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

  UserBaseOverViewModel toModel() => UserBaseOverViewModel(
        totalIncome: totalIncome,
        monthlyIncome: monthlyIncome,
        totalExpense: totalExpense,
        monthlyExpense: monthlyExpense,
      );
}
