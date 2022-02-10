import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoggedOut());

  void login() {
    emit(AuthLoggedIn());
  }

  void logOut() {
    emit(AuthLoggedOut());
  }

  void failedLogin() {
    emit(AuthLoggedOut());
  }

  void openLoader() {
    emit(AuthLoading());
  }
}
