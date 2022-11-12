import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/utils/response_error.dart';
import 'package:flutter/material.dart';

import '../../data/repository/auth_repo_impl.dart';
import '../../domain/repositories/repositories.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthModeStale());

  final AuthenticationRespository _authRepository =
      AuthenticationRespositoryImpl();

  Future<void> createUser(
      {required String username,
      required String password,
      required String email}) async {
    try {
      emit(AuthModeRequesting(message: "Creating user"));
      await _authRepository.createUser(
          email: email, username: username, password: password);
      emit(AuthModeLoggedIn());
    } on DioError catch (e) {
      emit(AuthFailed(err: e, errorMessage: e.response?.data ?? "Dio error"));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      emit(AuthFailed(err: e, errorMessage: "UNKNOWN ERROR"));
    }
  }

  Future<void> logUserIn({
    required String username,
    required String password,
  }) async {
    try {
      emit(AuthModeRequesting(message: "Requesting login for $username"));
      await _authRepository.logUserIn(username: username, password: password);
      emit(AuthModeLoggedIn());
    } on DioError catch (e) {
      emit(AuthFailed(
          err: e,
          errorMessage:
              showErrorsList(e.response?.data as Map<String, dynamic>?) ??
                  "Dio error"));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      emit(AuthFailed(err: e, errorMessage: "UNKNOWN ERROR"));
    }
  }

  void checkAuthState() async => await _authRepository.checkAuthState()
      ? emit(AuthModeLoggedIn())
      : emit(AuthModeLoggedOut());

  void logOut() async =>
      await _authRepository.logOut().then((value) => emit(AuthModeLoggedOut()));
}
