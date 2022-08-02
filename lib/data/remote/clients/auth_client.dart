import 'package:expense_tracker/data/util/auth_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

abstract class AuthClient {
  static final String _auth = dotenv.get('AUTH_ENDPOINT');

  final Dio dio = Dio()
    ..interceptors.add(AuthInterceptors(endPoint: _auth))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _auth,
      connectTimeout: 6000,
      receiveTimeout: 10000,
    );
}
