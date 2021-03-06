import 'package:expense_tracker/app/auth/auth.dart';
import 'package:expense_tracker/app/auth/auth_failed.dart';
import 'package:expense_tracker/app/home/drawer.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationCubit _authProvider =
        BlocProvider.of<AuthenticationCubit>(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthModeStale) {
          _authProvider.checkAuthState();
          return const AuthLoading();
        }
        if (state is AuthStateLoading) {
          return const AuthLoading();
        }
        if (state is AuthModeLoggedIn) {
          return const CustomDrawer();
        }

        return const AuthTabWrapper();
      },
    );
  }
}
