import 'package:json_annotation/json_annotation.dart';

part 'tokens_dto.g.dart';

@JsonSerializable()
class TokensDto {
  @JsonKey(name: "refresh")
  String refresh;
  @JsonKey(name: "access")
  String access;

  TokensDto({required this.refresh, required this.access});

  factory TokensDto.fromJson(Map<String, dynamic> json) =>
      _$TokensDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokensDtoToJson(this);
}
