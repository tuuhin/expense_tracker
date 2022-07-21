import 'package:expense_tracker/data/local/secure_storage.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

abstract class BaseClient {
  static final String _auth = dotenv.get('AUTH_ENDPOINT');
  static final String _api = dotenv.get('API_ENDPOINT');

  static final SecureStorage _storage = SecureStorage();

  static final Dio _tokenBearer = Dio()
    ..options = BaseOptions(
      baseUrl: _auth,
      headers: {'Content-type': 'application/json'},
    );

  static final Dio _resolveHandler = Dio()
    ..options = BaseOptions(
      baseUrl: _api,
      headers: {'Content-type': 'application/json'},
    );

  final Dio dio = Dio()
    ..interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        String? accessToken = await _storage.getAccessToken();
        if (accessToken != null) {
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        }
        return handler.next(options);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response!.statusCode == 401) {
          logger.fine('UNAUTHORIZE ERROR');
          String? refreshToken = await _storage.getRefreshToken();
          try {
            Response ref = await _tokenBearer
                .post('/refresh', data: {'refresh': refreshToken});
            String newAccessToken = ref.data['access'];
            await _storage.setAccessToken(newAccessToken);
            logger.finer('A new token has been assinged');
            Response response = await _resolveHandler.request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              options: Options(
                headers: {'Authorization': 'Bearer $newAccessToken'},
                method: error.requestOptions.method,
              ),
            );
            handler.resolve(response);
          } on DioError catch (dio) {
            logger.severe('DIO ERROR HAPPED!! ${dio.type}');
          } catch (e) {
            logger.severe(e.toString());
          }
        }
        // return handler.next(error);
      },
    ))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _api,
      connectTimeout: 6000,
      receiveTimeout: 10000,
    );
}
