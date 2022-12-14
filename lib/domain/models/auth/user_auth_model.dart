import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_auth_model.freezed.dart';

@freezed
class CreateUserModel with _$CreateUserModel {
  factory CreateUserModel({
    required String username,
    required String password,
    required String email,
  }) = _CreateUserModel;
}

@freezed
class LoginUserModel with _$LoginUserModel {
  factory LoginUserModel({
    required String username,
    required String password,
  }) = _LoginUserModel;
}
