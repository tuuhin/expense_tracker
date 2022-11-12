import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/auth/user_profile_model.dart';
import '../../entity/user/user_profile_entity.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserProfileDto {
  int? phoneNumber;
  String? firstName;
  String? lastName;
  String? photoURL;
  DateTime createdAt;
  DateTime updatedAt;
  String? email;

  UserProfileDto({
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.photoURL,
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfileEntity toEntity() => UserProfileEntity(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      photoURL: photoURL,
      createdAt: createdAt,
      updatedAt: updatedAt);

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
        updatedAt: userProfileModel.updatedAt,
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
  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);
}
