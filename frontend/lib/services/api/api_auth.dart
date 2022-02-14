import 'package:dio/dio.dart';
import 'package:expense_tracker/domain/data/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiAuth {
  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  static final SecureStorage _storage = SecureStorage();
  static final Dio _dio = Dio()
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _endPoint,
    );

  Future<Response?> createUser({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      Response _resp = await _dio.post('/create',
          data: {'username': username, 'password': password, 'email': email});
      Map _response = _resp.data as Map;

      await _storage.setAccessToken(_response['access']);
      await _storage.setRefreshToken(_response['refresh']);

      return _resp;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
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

      return _resp;
    } on DioError catch (e) {
      print('error');
      print(e.response!.statusCode);
      return e.response;
    } catch (e) {
      print(e.toString());
    }
  }
}
