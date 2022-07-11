abstract class SecureStorageRepository {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> setAccessToken(String? token);

  Future<void> setRefreshToken(String? token);

  Future<void> removeTokens();
}
