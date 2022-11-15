import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/context/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/routes/user/user_profile_change.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  void logOut() {
    context.read<AuthenticationCubit>().logOut();
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void _changePasswordRoute() =>
      Navigator.of(context).push(appRouteBuilder(const ChangePasswordRoute()));

  void _logoutDialog() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: logOut,
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              const ListTile(
                minVerticalPadding: 0,
                dense: true,
                title: Text('Account'),
              ),
              const Divider(),
              ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangeUserProfile())),
                leading: const Icon(Icons.person_outline_outlined),
                title: const Text('Change profile'),
              ),
              ListTile(
                onTap: _changePasswordRoute,
                leading: const Icon(Icons.visibility),
                title: const Text('Change password'),
              ),
              ListTile(
                onTap: _logoutDialog,
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
