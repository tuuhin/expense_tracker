import 'package:expense_tracker/app/auth/authentication.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit _auth = BlocProvider.of<AuthCubit>(context);
    return const Authentication();
  }
}
