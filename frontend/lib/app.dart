import 'package:expense_tracker/app/auth/auth_state_loading.dart';
import 'package:expense_tracker/app/auth/authentication.dart';
import 'package:expense_tracker/app/home/home.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoggedOut) return const Authentication();
        if (state is AuthLoggedIn) return const Home();
        if (state is AuthLoading) return const AuthLoadingState();
        return const SizedBox.expand();
      },
    );
  }
}
