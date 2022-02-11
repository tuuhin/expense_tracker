import 'package:expense_tracker/services/api/api_client.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient _clt = ApiClient();
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                _authCubit.removeAuthState();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await _clt.getIncomes();
            },
            child: const Text('hi')),
      ),
    );
  }
}
