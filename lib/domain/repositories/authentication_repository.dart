abstract class AuthenticationRespository {
  Future<void> createUser({
    required String username,
    required String password,
    required String email,
  });

  Future<void> logUserIn({
    required String username,
    required String password,
  });

  Future<void> logOut();

  Future<bool> checkAuthState();
}
