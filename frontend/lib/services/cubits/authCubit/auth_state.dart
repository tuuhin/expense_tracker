part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthLoggedOut extends AuthState {}
