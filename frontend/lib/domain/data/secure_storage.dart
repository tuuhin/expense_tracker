import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getAccessToken() async =>
      await _storage.read(key: 'accessToken');

  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refreshToken');

  Future setAccessToken(String token) async =>
      await _storage.write(key: 'accessToken', value: token);

  Future setRefreshToken(String token) async =>
      await _storage.write(key: 'refreshToken', value: token);

  Future removeTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
