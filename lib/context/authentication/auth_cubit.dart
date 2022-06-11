import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/local/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

Future delay() async => Future.delayed(const Duration(seconds: 2));

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthModeStale());

  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  static final SecureStorage _storage = SecureStorage();
  static final Dio _dio = Dio()
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _endPoint,
    );

  void _login() => emit(AuthModeLoggedIn());

  void _logOut() => emit(AuthModeLoggedOut());

  void _loading() => emit(AuthStateLoading());

  void _responseFailed({String? details, String? code}) =>
      emit(AuthStateFailed(code: code, details: details));

  Future<Response?> createUser({
    required String username,
    required String password,
    required String email,
  }) async {
    _loading();
    await delay();
    try {
      Response _resp = await _dio.post('/create', data: {
        'username': username,
        'password': password,
        'email': email,
      });
      Map _response = _resp.data as Map;

      await _storage.setAccessToken(_response['access']);
      await _storage.setRefreshToken(_response['refresh']);
      _login();
    } on DioError catch (e) {
      if (e.response != null) {
        Map _response = e.response!.data as Map;
        print(e.response!.data);

        _responseFailed(
          details: _response['details'],
          code: _response['code'],
        );
      }

      return null;
    } catch (e) {
      _responseFailed(
        details: e.toString(),
      );
      print(e.toString());
    }
    return null;
  }

  Future<Response?> logUserIn({
    required String username,
    required String password,
  }) async {
    _loading();
    await delay();
    try {
      Response _resp = await _dio
          .post('/token', data: {'username': username, 'password': password});
      Map _responseData = _resp.data as Map;

      await _storage.setAccessToken(_responseData['access']);
      await _storage.setRefreshToken(_responseData['refresh']);
      _login();

      return _resp;
    } on DioError catch (e) {
      if (e.response != null) {
        Map _response = e.response!.data as Map;
        print(e.response!.data);

        _responseFailed(
          details: _response['details'],
          code: _response['code'],
        );
      }

      return null;
    } catch (e) {
      _responseFailed(
        details: e.toString(),
      );
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
    _logOut();
  }
}
