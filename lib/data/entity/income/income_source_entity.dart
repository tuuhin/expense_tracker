import 'package:hive/hive.dart';

part 'income_source_entity.g.dart';

@HiveType(typeId: 05)
class IncomeSourceEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? desc;

  @HiveField(3)
  final bool? isSecure;

  IncomeSourceEntity(
      {required this.id, required this.title, this.desc, this.isSecure});
}
