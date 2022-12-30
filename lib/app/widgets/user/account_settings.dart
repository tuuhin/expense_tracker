import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:go_router/go_router.dart";

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  void logOut() {
    context.read<AuthenticationCubit>().logOut();
    context.read<EntriesBloc>().clear();
    // context.read<NotificationBloc>().close();
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void _logoutDialog() async =>
      showDialog(context: context, builder: (context) => const LogoutDialog());

  void _changeProfile() => context.push(
        "/change-profile",
        extra: context.read<ProfileCubit>().cahcedData(),
      );

  void _changePassword() => context.push("/change-password");

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: _changeProfile,
                  leading: Image.asset("assets/icons/user.png"),
                  title: const Text('Change profile'),
                ),
                ListTile(
                  onTap: _changePassword,
                  leading: Image.asset("assets/icons/key-chain.png"),
                  title: const Text('Change password'),
                ),
                ListTile(
                  onTap: _logoutDialog,
                  leading: Image.asset("assets/icons/shutdown.png"),
                  title: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
