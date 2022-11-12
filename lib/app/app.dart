import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../context/authentication/auth_cubit.dart';
import './auth/auth_loading_page.dart';
import './auth/auth_tabs_wrapper.dart';
import './home/drawer.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check auth state isLogged or notLogged
    context.read<AuthenticationCubit>().checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listenWhen: (previous, current) =>
          current is AuthModeRequesting ||
          current is AuthFailed ||
          current is AuthModeLoggedIn,
      listener: (context, state) {
        if (state is AuthModeLoggedIn) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("😙 Welcome user"),
                    content: const Text(
                        "Hope this app helps in maintaing your data"),
                    actions: [
                      TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text("Ok!"))
                    ],
                  ));
        }
        if (state is AuthModeRequesting) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2)));
        }
        if (state is AuthFailed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("❗🦀Error"),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Try Again'))
              ],
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is! AuthModeRequesting || current is! AuthFailed,
      builder: (context, state) {
        if (state is AuthModeStale) return const AuthLoading();
        if (state is AuthModeLoggedIn) return const CustomDrawer();
        return const AuthTabWrapper();
      },
    );
  }
}
