import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../../util/auth_interceptor.dart';

abstract class ResourceClient {
  static final String _api = dotenv.get('API_ENDPOINT');

  final Dio dio = Dio()
    ..options = BaseOptions(
      responseType: ResponseType.json,
      contentType: 'application/json',
      baseUrl: _api,
      connectTimeout: 4000,
      receiveTimeout: 8000,
    )
    ..interceptors.add(
      AuthInterceptors(endPoint: _api),
    );
}
