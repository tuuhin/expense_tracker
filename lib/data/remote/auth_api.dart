import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dto/dto.dart';

class AuthApi {
  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  final Dio dio = Dio()
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _endPoint,
    );

  Future<AuthResultsDto> createUser(CreateUserDto dto) async {
    Response resp = await dio.post('/create', data: dto.toJson());
    return AuthResultsDto.fromJson(resp.data);
  }

  Future<AuthResultsDto> loginUser(LoginUserDto dto) async {
    Response response = await dio.post('/token', data: dto.toJson());
    return AuthResultsDto.fromJson(response.data);
  }

  Future<TokensDto> checkAuthState({required String token}) async {
    Response resp = await dio.get('/check-auth',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return TokensDto.fromJson(resp.data);
  }
}
