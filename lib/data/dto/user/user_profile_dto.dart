import 'package:expense_tracker/domain/models/auth/user_profile_model.dart';

import '../../entity/user/user_profile_entity.dart';

class UserProfileDto {
  int? phoneNumber;
  String? firstName;
  String? lastName;
  String? photoURL;
  String? createdAt;
  String? updatedAt;
  String? email;

  UserProfileDto({
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  UserProfileEntity toEntity() {
    return UserProfileEntity(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        photoURL: photoURL,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  UserProfileModel toModel() => UserProfileModel(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      photoURL: photoURL,
      createdAt: createdAt,
      updatedAt: updatedAt);

  factory UserProfileDto.fromModel(UserProfileModel userProfileModel) =>
      UserProfileDto(
          phoneNumber: userProfileModel.phoneNumber,
          firstName: userProfileModel.firstName,
          lastName: userProfileModel.lastName,
          photoURL: userProfileModel.photoURL,
          createdAt: userProfileModel.createdAt,
          updatedAt: userProfileModel.updatedAt);

  factory UserProfileDto.fromJson(Map<String, dynamic> json) => UserProfileDto(
        phoneNumber: json['phoneNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        photoURL: json['photoURL'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  factory UserProfileDto.fromEntity(UserProfileEntity entity) {
    return UserProfileDto(
      phoneNumber: entity.phoneNumber,
      firstName: entity.firstName,
      lastName: entity.lastName,
      photoURL: entity.photoURL,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'photoURL': photoURL,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
