import 'package:hive/hive.dart';

part 'expense_categories_entity.g.dart';

@HiveType(typeId: 03)
class ExpenseCategoriesEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? desc;

  ExpenseCategoriesEntity({
    required this.id,
    required this.title,
    this.desc,
  });
}
