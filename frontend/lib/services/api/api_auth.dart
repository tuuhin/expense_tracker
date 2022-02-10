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

  Future<bool?> signUserIn(
      {required String username,
      required String password,
      required String email}) async {}

  Future<void> logUserOut() async {
    await _storage.removeTokens();
  }

  Future<bool> logUserIn({
    required String username,
    required String password,
  }) async {
    try {
      Response _resp = await _dio
          .post('/token', data: {'username': username, 'password': password});
      Map _responseData = _resp.data as Map;
      print(_responseData);

      await _storage.setAccessToken(_responseData['access']);
      await _storage.setRefreshToken(_responseData['refresh']);

      return true;
    } on DioError catch (e) {
      print(e.response);
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
