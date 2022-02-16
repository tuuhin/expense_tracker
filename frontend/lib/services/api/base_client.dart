import 'package:expense_tracker/domain/data/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

abstract class Client {
  static final String _auth = dotenv.get('AUTH_ENDPOINT');
  static final String _api = dotenv.get('API_ENDPOINT');

  static final SecureStorage _storage = SecureStorage();

  static final Dio _tokenBearer = Dio()
    ..options = BaseOptions(
      baseUrl: _auth,
      headers: {'Content-type': 'application/json'},
    );

  static final Dio dio = Dio()
    ..interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        String? _accessToken = await _storage.getAccessToken();
        if (_accessToken != null) {
          options.headers.addAll({'Authorization': 'Bearer $_accessToken'});
        }
        return handler.next(options);
      },
      onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
      ) async =>
          handler.next(response),
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response!.statusCode == 401) {
          String? _refreshToken = await _storage.getRefreshToken();
          try {
            Response _ref = await _tokenBearer
                .post('/refresh', data: {'refresh': _refreshToken});
            String newAccessToken = _ref.data['access'];
            _storage.setAccessToken(newAccessToken);
            print('A new refresh token has been assigned ');
            await dio.request(error.requestOptions.path,
                data: error.requestOptions.data);
            print('Again calling the same api');
          } on DioError catch (error) {
            print(error.response);
            print('token invalid');
          } catch (e) {
            print(e.toString());
          }
        }
        return handler.next(error);
      },
    ))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _api,
    );
}
