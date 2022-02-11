import 'package:expense_tracker/domain/data/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final String _auth = dotenv.get('AUTH_ENDPOINT');
  static final String _api = dotenv.get('API_ENDPOINT');

  static final SecureStorage _storage = SecureStorage();

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
    );

  Future<void> getIncomes() async {
    try {
      Response _resp = await _dio.get('/income');
      print(_resp.data);
    } on DioError catch (e) {
      print(e.response);
    } catch (e) {
      print(e.toString());
    }
  }
}
