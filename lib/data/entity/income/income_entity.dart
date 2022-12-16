import 'package:hive/hive.dart';

import '../entity.dart';
part 'income_entity.g.dart';

@HiveType(typeId: 06)
class IncomeEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime addedAt;

  @HiveField(4)
  final List<IncomeSourceEntity> sources;

  @HiveField(5)
  final String? desc;

  IncomeEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    required this.sources,
    this.desc,
  });
}
