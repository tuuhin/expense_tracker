import 'package:expense_tracker/domain/models/auth/user_profile_model.dart';

class UserProfileDto {
  int? phoneNumber;
  String? firstName;
  String? lastName;
  String? photoURL;
  String? createdAt;
  String? updatedAt;

  UserProfileDto({
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  UserProfileModel toUserProfileModel() => UserProfileModel(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      photoURL: photoURL,
      createdAt: createdAt,
      updatedAt: updatedAt);

  factory UserProfileDto.fromUserProfileModel(
          UserProfileModel userProfileModel) =>
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
        photoURL: json['photoURL'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'photoURL': photoURL,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
