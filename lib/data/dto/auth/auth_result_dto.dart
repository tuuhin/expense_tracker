import 'package:json_annotation/json_annotation.dart';
import '../dto.dart';

part 'auth_result_dto.g.dart';

@JsonSerializable()
class AuthResultsDto {
  @JsonKey(name: "tokens")
  final TokensDto token;

  @JsonKey(name: "profile")
  final UserProfileDto profile;

  AuthResultsDto({required this.profile, required this.token});

  factory AuthResultsDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResultsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultsDtoToJson(this);
}
