import '../models/models.dart';
import '../../utils/resource.dart';

abstract class AuthRespository {
  Future<Resource> createUser(CreateUserModel user);

  Future<Resource> logUserIn(LoginUserModel user);

  Future<void> logOut();

  Future<Resource> checkAuthState();
}
