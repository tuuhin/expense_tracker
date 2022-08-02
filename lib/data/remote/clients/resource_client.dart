import 'package:expense_tracker/data/util/auth_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

abstract class ResourceClient {
  static final String _api = dotenv.get('API_ENDPOINT');

  final Dio dio = Dio()
    ..interceptors.add(AuthInterceptors(endPoint: _api))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _api,
      connectTimeout: 6000,
      receiveTimeout: 10000,
    );
}
