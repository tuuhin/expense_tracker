import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/auth_client.dart';

class AuthApi extends AuthClient {
  Future<AuthResultsDto> createUser(CreateUserDto dto) async {
    Response resp = await dio.post('/create', data: dto.toJson());
    return AuthResultsDto.fromJson(resp.data);
  }

  Future<AuthResultsDto> loginUser(LoginUserDto dto) async {
    Response response = await dio.post('/token', data: dto.toJson());
    return AuthResultsDto.fromJson(response.data);
  }

  Future<TokensDto> checkAuthState({required String token}) async {
    Response resp = await dio.post('/refresh',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return TokensDto.fromJson(resp.data);
  }
}
