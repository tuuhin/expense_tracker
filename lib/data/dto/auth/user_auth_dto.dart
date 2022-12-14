import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'user_auth_dto.g.dart';

@JsonSerializable()
class CreateUserDto {
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "email")
  final String email;

  CreateUserDto(
      {required this.username, required this.password, required this.email});

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  factory CreateUserDto.fromModel(CreateUserModel model) => CreateUserDto(
      username: model.username, password: model.password, email: model.email);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);

  CreateUserModel toModel() =>
      CreateUserModel(username: username, password: password, email: email);
}

@JsonSerializable()
class LoginUserDto {
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "password")
  final String password;

  LoginUserDto({required this.username, required this.password});

  factory LoginUserDto.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDtoFromJson(json);

  factory LoginUserDto.fromModel(LoginUserModel model) =>
      LoginUserDto(username: model.username, password: model.password);

  Map<String, dynamic> toJson() => _$LoginUserDtoToJson(this);

  LoginUserModel toModel() =>
      LoginUserModel(username: username, password: password);
}
