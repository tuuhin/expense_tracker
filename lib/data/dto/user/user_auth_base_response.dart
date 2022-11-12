import 'package:expense_tracker/data/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_auth_base_response.g.dart';

@JsonSerializable()
class UserAuthBaseResponseDto {
  @JsonKey(name: "tokens")
  final TokensDto tokens;
  @JsonKey(name: "profile")
  final UserProfileDto profile;

  UserAuthBaseResponseDto({required this.tokens, required this.profile});

  factory UserAuthBaseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserAuthBaseResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthBaseResponseDtoToJson(this);
}
