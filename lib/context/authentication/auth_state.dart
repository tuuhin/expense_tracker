part of 'auth_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState.loggedIn() = _LoggedIn;
  factory AuthenticationState.loggedOut() = _LoggedOut;
  factory AuthenticationState.requestFailed(
      {required Object err, required String message}) = _Failed;
  factory AuthenticationState.requesting({required String message}) =
      _Requesting;
  factory AuthenticationState.checkState() = _CheckState;
}
