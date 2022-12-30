import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool _isCacheDeleting = false;

  void _logOut() async {
    await _deleteCache();
    if (!mounted) return;

    context.read<AuthenticationCubit>().logOut();
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  Future<void> _deleteCache() async {
    setState(() => _isCacheDeleting = true);

    await Future.wait<void>(
      [
        context.read<IncomeCubit>().clearCache(),
        context.read<ExpenseCubit>().clearCache(),
        context.read<ProfileCubit>().clearCache(),
        context.read<BudgetCubit>().clearCache(),
        context.read<GoalsBloc>().clearCache(),
        context.read<EntriesBloc>().clear(),
        context.read<NotificationBloc>().clear(),
        context.read<ProfileCubit>().clearCache(),
        context.read<BaseInformationCubit>().clearCache()
      ],
      cleanUp: (successValue) => setState(() => _isCacheDeleting = false),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Logout', style: Theme.of(context).textTheme.subtitle1),
        content: SizedBox(
          height: 30,
          child: Center(
            child: _isCacheDeleting
                ? const CircularProgressIndicator()
                : Text('Are you sure you wanna logout',
                    style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          ElevatedButton(onPressed: _logOut, child: const Text('Logout'))
        ],
      );
}
