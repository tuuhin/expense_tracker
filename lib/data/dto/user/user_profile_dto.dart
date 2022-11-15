import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/auth/user_profile_model.dart';
import '../../entity/user/user_profile_entity.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserProfileDto {
  @JsonKey(name: "phoneNumber")
  int? phoneNumber;
  @JsonKey(name: "firstName")
  String firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "photoURL")
  String? photoURL;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "email")
  String? email;

  UserProfileDto({
    this.phoneNumber,
    this.email,
    required this.firstName,
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

  factory UserProfileDto.fromModel(UserProfileModel model) => UserProfileDto(
      phoneNumber: model.phoneNumber,
      firstName: model.firstName,
      lastName: model.lastName,
      photoURL: model.photoURL,
      createdAt: model.createdAt ?? DateTime.now(),
      updatedAt: model.updatedAt,
      email: model.email);

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
