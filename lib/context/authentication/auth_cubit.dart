import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/dto/dto.dart';
import '../../data/local/storage.dart';
import '../../domain/models/auth/tokens.dart';
import '../../domain/models/models.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthModeStale());

  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  final SecureStorage _storage = SecureStorage();

  final UserProfileData _data = UserProfileData();
  final Dio _dio = Dio()
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _endPoint,
    );

  void _login() => emit(AuthModeLoggedIn());

  void _logOut() => emit(AuthModeLoggedOut());

  Future<Response?> createUser({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      Response response = await _dio.post('/create', data: {
        'username': username,
        'password': password,
        'email': email,
      });

      Map mapedResponse = response.data as Map;

      Token tokens = TokensDto.fromJson(mapedResponse['tokens']).toToken();
      UserProfileModel userProfile =
          UserProfileDto.fromJson(mapedResponse['profile']).toModel();

      await _storage.setAccessToken(tokens.access);
      await _storage.setRefreshToken(tokens.refresh);
      _login();
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Response?> logUserIn({
    required String username,
    required String password,
  }) async {
    try {
      Response response = await _dio
          .post('/token', data: {'username': username, 'password': password});
      Map mapedResponse = response.data as Map;
      Token tokens = TokensDto.fromJson(mapedResponse['tokens']).toToken();
      UserProfileModel userProfile =
          UserProfileDto.fromJson(mapedResponse['profile']).toModel();

      await _storage.setAccessToken(tokens.access);
      await _storage.setRefreshToken(tokens.refresh);
      _login();
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void checkAuthState() async {
    String? token = await _storage.getAccessToken();
    if (token == null) return _logOut();
    return _login();
  }

  void logOut() async {
    await _storage.removeTokens();
    await _data.removeUserProfile();
    _logOut();
  }
}
