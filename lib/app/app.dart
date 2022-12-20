import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../context/context.dart';
import './auth/auth_loading_page.dart';
import './auth/auth_tabs_wrapper.dart';
import './home/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) => state.whenOrNull(
        requesting: (message) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message))),
        requestFailed: (err, message) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Authentication failed"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Ok! I got it"))
            ],
          ),
        ),
      ),
      builder: (context, state) => state.maybeWhen(
        orElse: () => const AuthTabWrapper(),
        loggedIn: () => const Home(),
        checkState: () => const AuthLoadingScreen(),
      ),
    );
  }
}
