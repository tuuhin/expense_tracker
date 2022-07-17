import 'package:expense_tracker/domain/models/auth/user_profile_model.dart';
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

  UserProfileModel toUserProfileModel() {
    return UserProfileModel(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        photoURL: photoURL,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  factory UserProfileEntity.fromUserProfileModel(
      UserProfileModel userProfileModel) {
    return UserProfileEntity(
        phoneNumber: userProfileModel.phoneNumber,
        firstName: userProfileModel.firstName,
        lastName: userProfileModel.lastName,
        photoURL: userProfileModel.photoURL,
        createdAt: userProfileModel.createdAt,
        updatedAt: userProfileModel.updatedAt);
  }
}
