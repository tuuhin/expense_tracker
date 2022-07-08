import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/local/storage.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthModeStale());

  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  final SecureStorage _storage = SecureStorage();
  final UserData _data = UserData();
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
      Response _resp = await _dio.post('/create', data: {
        'username': username,
        'password': password,
        'email': email,
      });

      Map _response = _resp.data as Map;

      Tokens _tokens = Tokens.fromJson(_response['tokens']);
      print(_tokens);
      await _storage.setAccessToken(_tokens.access);
      await _storage.setRefreshToken(_tokens.refresh);
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
      Response _resp = await _dio
          .post('/token', data: {'username': username, 'password': password});
      Map _responseData = _resp.data as Map;

      await _storage.setAccessToken(_responseData['access']);
      await _storage.setRefreshToken(_responseData['refresh']);
      _login();
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void checkAuthState() async {
    String? _token = await _storage.getAccessToken();
    if (_token == null) return _logOut();
    return _login();
  }

  void logOut() async {
    await _storage.removeTokens();
    await _data.removeUser();
    _logOut();
  }
}
