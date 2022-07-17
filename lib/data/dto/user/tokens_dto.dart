import 'package:expense_tracker/domain/models/auth/tokens.dart';

class TokensDto {
  String? refresh;
  String? access;

  TokensDto({this.refresh, this.access});

  factory TokensDto.fromToken(Token token) =>
      TokensDto(access: token.access, refresh: token.refresh);

  Token toToken() => Token(access: access, refresh: refresh);

  factory TokensDto.fromJson(Map<String, dynamic> json) =>
      TokensDto(refresh: json['refresh'], access: json['access']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'refresh': refresh, 'access': access};
}
