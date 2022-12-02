import 'package:hive/hive.dart';

part 'goals_entity.g.dart';

@HiveType(typeId: 09)
class GoalsEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? desc;

  @HiveField(3)
  final double collected;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
  final double price;

  @HiveField(7)
  final bool accomplished;

  @HiveField(8)
  final String? image;

  GoalsEntity({
    required this.id,
    required this.title,
    required this.collected,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.accomplished,
    this.desc,
    this.image,
  });
}
