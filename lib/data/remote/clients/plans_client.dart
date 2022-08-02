import 'package:expense_tracker/data/util/auth_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

abstract class PlansClient {
  static final String _plans = dotenv.get('PLANS_ENDPOINT');

  final Dio dio = Dio()
    ..interceptors.add(AuthInterceptors(endPoint: _plans))
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _plans,
      connectTimeout: 6000,
      receiveTimeout: 10000,
    );
}
