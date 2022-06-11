part of 'auth_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthModeLoggedIn extends AuthenticationState {}

class AuthModeLoggedOut extends AuthenticationState {}

class AuthModeStale extends AuthenticationState {}

class AuthStateLoading extends AuthenticationState {}

class AuthStateFailed extends AuthenticationState {
  final String? details;
  final String? code;
  AuthStateFailed({this.details, this.code});
}
