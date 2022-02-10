import 'package:expense_tracker/domain/data/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class DioApiClient {
  static final SecureStorage _storage = SecureStorage();
  static final String _auth = dotenv.get('AUTH_ENDPOINT');
  static final String _api = dotenv.get('API_ENDPOINT');
  static final Dio _tokenBearer = Dio()
    ..options = BaseOptions(
      baseUrl: _auth,
      headers: {'Content-type': 'application/json'},
    );

  static final Dio _dio = Dio()
    ..interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) async {
      String? _accessToken = await _storage.getAccessToken();
      if (_accessToken != null) {
        options.headers.addAll({'Authorization': 'Bearer $_accessToken'});
      }
      return handler.next(options);
    }, onResponse: (
      Response response,
      ResponseInterceptorHandler handler,
    ) async {
      if (response.statusCode == 401) {
        String? _refreshToken = await _storage.getRefreshToken();
        try {
          Response _ref = await _tokenBearer
              .post('/refresh', data: {'refresh': _refreshToken});
          String newAccessToken = _ref.data['access'];
          _storage.setAccessToken(newAccessToken);
        } on DioError catch (error) {
          print(error.response);
        } catch (e) {
          print(e.toString());
        }
      }
    }))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _api,
      connectTimeout: 6000,
      receiveTimeout: 10000,
    );

  Future<void> getIncomes() async {}
}
