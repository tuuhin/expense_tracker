import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._repo) : super(AuthenticationState.checkState());

  final AuthRespository _repo;

  Future<void> createUser(CreateUserModel user) async {
    emit(AuthenticationState.requesting(message: "Creating user"));
    Resource resource = await _repo.createUser(user);

    resource.whenOrNull(
      data: (data, message) => emit(AuthenticationState.loggedIn()),
      error: (err, errorMessage, data) => emit(
        AuthenticationState.requestFailed(err: err, message: errorMessage),
      ),
    );
  }

  Future<void> logUserIn(LoginUserModel user) async {
    emit(AuthenticationState.requesting(
        message: "Requesting login for ${user.username}"));
    Resource login = await _repo.logUserIn(user);

    login.whenOrNull(
      data: (data, message) => emit(AuthenticationState.loggedIn()),
      error: (err, errorMessage, data) => emit(
        AuthenticationState.requestFailed(err: err, message: errorMessage),
      ),
    );
  }

  void checkAuthState() async {
    Resource authState = await _repo.checkAuthState();

    authState.whenOrNull(
      data: (data, message) => emit(AuthenticationState.loggedIn()),
      error: (err, errorMessage, data) => emit(AuthenticationState.loggedOut()),
    );
  }

  void logOut() async {
    await _repo.logOut();
    emit(AuthenticationState.loggedOut());
  }
}
