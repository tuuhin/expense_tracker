import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async =>
      await _storage.read(key: 'accessToken');

  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refreshToken');

  Future<Map<String, String?>> getTokenPair() async => <String, String?>{
        "access": await getAccessToken(),
        "refresh": await getRefreshToken(),
      };

  Future<void> setAccessToken(String? token) async =>
      await _storage.write(key: 'accessToken', value: token);

  Future<void> setRefreshToken(String? token) async =>
      await _storage.write(key: 'refreshToken', value: token);

  Future<void> setTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: "accessToken", value: access);
    await _storage.write(key: "refreshToken", value: refresh);
  }

  Future<void> removeTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
