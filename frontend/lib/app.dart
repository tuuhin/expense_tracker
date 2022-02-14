import 'package:expense_tracker/app/auth/auth.dart';
import 'package:expense_tracker/app/home/drawer.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit _authProvider = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthStaleState) {
          _authProvider.checkAuthState();
          return const AuthLoading();
        }
        if (state is AuthLoggedOut) return const Authentication();
        if (state is AuthLoggedIn) return const CustomDrawer();
        return const SizedBox.expand();
      },
    );
  }
}
