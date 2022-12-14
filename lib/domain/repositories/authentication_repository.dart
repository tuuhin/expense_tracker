import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class AuthRespository {
  Future<Resource> createUser(CreateUserModel user);

  Future<Resource> logUserIn(LoginUserModel user);

  Future<void> logOut();

  Future<Resource> checkAuthState();
}
