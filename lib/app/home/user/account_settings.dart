import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/home/user/user.dart';
import 'package:expense_tracker/context/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  void _logout() async => await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<AuthenticationCubit>().logOut();
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              child: Text('Logout',
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                onTap: () => Navigator.of(context)
                    .push(appRouteBuilder(const ChangePassword())),
                leading: const Icon(Icons.visibility),
                title: const Text('Change password'),
              ),
              ListTile(
                onTap: _logout,
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
