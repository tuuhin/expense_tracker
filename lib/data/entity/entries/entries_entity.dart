import 'package:hive/hive.dart';
part 'entries_entity.g.dart';

@HiveType(typeId: 07)
class EntriesEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String? desc;

  @HiveField(4)
  final bool? isSecure;

  EntriesEntity({
    required this.id,
    required this.title,
    required this.type,
    this.isSecure,
    this.desc,
  });
}
