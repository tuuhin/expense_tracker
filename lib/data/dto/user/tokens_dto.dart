import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/auth/tokens.dart';

part 'tokens_dto.g.dart';

@JsonSerializable()
class TokensDto {
  String? refresh;
  String? access;

  TokensDto({this.refresh, this.access});

  factory TokensDto.fromToken(Token token) =>
      TokensDto(access: token.access, refresh: token.refresh);

  Token toToken() => Token(access: access, refresh: refresh);

  factory TokensDto.fromJson(Map<String, dynamic> json) =>
      _$TokensDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokensDtoToJson(this);
}
