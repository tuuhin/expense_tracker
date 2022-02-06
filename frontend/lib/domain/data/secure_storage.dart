import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: 'accessToken');

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refreshToken');

  static Future setAccessToken(String token) async =>
      await _storage.write(key: 'accessToken', value: token);

  static Future setRefreshToken(String token) async =>
      await _storage.write(key: 'refreshToken', value: token);

  static Future removeAcessToken(String token) async =>
      await _storage.delete(key: 'accessToken');

  static Future removeRefreshToken(String token) async =>
      await _storage.delete(key: 'refreshToken');
}
