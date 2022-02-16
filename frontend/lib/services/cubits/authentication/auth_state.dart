part of 'auth_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthModeLoggedIn extends AuthenticationState {}

class AuthModeLoggedOut extends AuthenticationState {}

class AuthModeStale extends AuthenticationState {}
