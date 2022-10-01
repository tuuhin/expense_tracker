import 'package:dio/dio.dart';
import 'package:expense_tracker/data/local/storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../main.dart';

class AuthInterceptors extends QueuedInterceptor {
  static final String _auth = dotenv.get('AUTH_ENDPOINT');

  final String endPoint;
  AuthInterceptors({required this.endPoint});

  final SecureStorage _storage = SecureStorage();

  final Dio _tokenBearer = Dio()
    ..options = BaseOptions(
      baseUrl: _auth,
      headers: {'Content-type': 'application/json'},
    );

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      logger.fine('UNAUTHORIZE ERROR');
      String? refreshToken = await _storage.getRefreshToken();
      try {
        Response ref = await _tokenBearer
            .post('/refresh', data: {'refresh': refreshToken});
        String newAccessToken = ref.data['access'];
        await _storage.setAccessToken(newAccessToken);
        logger.finer('A new token has been assinged');
        final Dio resolveHandler = Dio()
          ..options = BaseOptions(
            baseUrl: endPoint,
            headers: {'Content-type': 'application/json'},
          );
        Response response = await resolveHandler.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          options: Options(
            headers: {'Authorization': 'Bearer $newAccessToken'},
            method: err.requestOptions.method,
          ),
        );
        handler.resolve(response);
        resolveHandler.close();
        logger.info('Removing the previous connection');
      } on DioError catch (dio) {
        logger.severe('DIO ERROR HAPPED!! ${dio.type}');
      } catch (e) {
        logger.severe(e.toString());
      }
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    return handler.next(options);
  }
}
