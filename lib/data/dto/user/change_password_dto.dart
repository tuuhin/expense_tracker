import 'package:json_annotation/json_annotation.dart';

part 'change_password_dto.g.dart';

@JsonSerializable()
class ChangePasswordDto {
  @JsonKey(name: "old_password")
  final String oldPassword;
  @JsonKey(name: "new_password")
  final String newPassword;

  ChangePasswordDto({required this.oldPassword, required this.newPassword});

  factory ChangePasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordDtoToJson(this);
}
