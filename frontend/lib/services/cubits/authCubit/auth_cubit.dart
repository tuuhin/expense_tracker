import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/data/secure_storage.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStaleState());
  static final SecureStorage _storage = SecureStorage();

  void _login() => emit(AuthLoggedIn());

  void _logOut() => emit(AuthLoggedOut());

  void removeAuthState() async {
    await _storage.removeTokens();
    _logOut();
  }

  void checkAuthState() => changeAuthState();

  void changeAuthState() async {
    String? _token = await _storage.getAccessToken();
    if (_token == null) return _logOut();
    return _login();
  }
}
