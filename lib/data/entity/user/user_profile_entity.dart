import 'package:hive/hive.dart';

part 'user_profile_entity.g.dart';

@HiveType(typeId: 01)
class UserProfileEntity extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? phoneNumber;

  @HiveField(2)
  String? firstName;

  @HiveField(3)
  String? lastName;

  @HiveField(4)
  String? photoURL;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? updatedAt;

  UserProfileEntity({
    this.id,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });
}
