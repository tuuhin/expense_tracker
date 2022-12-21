import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../widgets/user/change_password_fields.dart';

class ChangePasswordRoute extends StatefulWidget {
  const ChangePasswordRoute({Key? key}) : super(key: key);

  @override
  State<ChangePasswordRoute> createState() => _ChangePasswordRouteState();
}

class _ChangePasswordRouteState extends State<ChangePasswordRoute> {
  late TextEditingController _oldPassword;
  late TextEditingController _newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    await context
        .read<ProfileCubit>()
        .changePassword(_oldPassword.text, _newPassword.text);
  }

  @override
  void initState() {
    super.initState();
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) => state.whenOrNull(
          successful: (message) => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            ),
          requesting: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Changing your password"))),
          unSuccessful: (err, message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset('assets/flaticons/key.png', scale: 3),
              ),
              Expanded(
                child: Form(
                    key: _formKey,
                    child: ChangePasswordFields(
                      oldController: _oldPassword,
                      newController: _newPassword,
                    )),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  fixedSize: Size(size.width, 50)),
              onPressed: _changePassword,
              child: const Text('Change Password')),
        ),
      ),
    );
  }
}
