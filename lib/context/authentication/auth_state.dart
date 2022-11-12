part of 'auth_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthModeLoggedIn extends AuthenticationState {
  final String? message;

  AuthModeLoggedIn({this.message});
}

class AuthModeLoggedOut extends AuthenticationState {}

class AuthModeStale extends AuthenticationState {}

class AuthModeRequesting extends AuthenticationState {
  final String message;

  AuthModeRequesting({required this.message});
}

class AuthFailed extends AuthenticationState {
  final Object err;
  final String errorMessage;

  AuthFailed({
    required this.err,
    required this.errorMessage,
  });
}
