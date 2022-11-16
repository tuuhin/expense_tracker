import 'package:expense_tracker/utils/app_images.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/user_profile_repository.dart';

class ChangePasswordRoute extends StatefulWidget {
  const ChangePasswordRoute({Key? key}) : super(key: key);

  @override
  State<ChangePasswordRoute> createState() => _ChangePasswordRouteState();
}

class _ChangePasswordRouteState extends State<ChangePasswordRoute> {
  late TextEditingController _oldPassword;
  late TextEditingController _newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;

  bool _changeInProgress = true;

  void _changePassword() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _changeInProgress = false;
    Resource resource = await context
        .read<UserProfileRepository>()
        .changePassword(_oldPassword.text, _newPassword.text);
    resource.maybeWhen(
      orElse: () {},
      error: (err, errorMessage, data) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      },
      data: (data, message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message ?? "Successfull")));
      },
    );
    _changeInProgress = true;
  }

  String? _validateOldPassword(String? value) {
    if (value?.isEmpty == true) {
      return 'Enter the old password';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value?.isEmpty == true) return 'Enter the new password';
    if (value != null && value.length < 5) {
      return 'Enter at-least 5 characters';
    }
    return null;
  }

  Future<bool> _willPopDialog() async {
    if (!_changeInProgress) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Plz wait'),
          content: const Text('Change in Progress Please Wait'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop, child: const Text('Ok!'))
          ],
        ),
      );
    }
    return _changeInProgress;
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
    return WillPopScope(
      onWillPop: _willPopDialog,
      child: Scaffold(
        appBar: AppBar(title: const Text('Change Password')),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: changePassword,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        validator: _validateOldPassword,
                        controller: _oldPassword,
                        obscureText: !_isOldPasswordVisible,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          suffixIcon: IconButton(
                            onPressed: () => setState(() =>
                                _isOldPasswordVisible = !_isOldPasswordVisible),
                            icon: Icon(_isOldPasswordVisible
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: _validateNewPassword,
                        controller: _newPassword,
                        obscureText: !_isNewPasswordVisible,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          helperText:
                              'The password should be atleast of 5 characters',
                          suffixIcon: IconButton(
                            onPressed: () => setState(() =>
                                _isNewPasswordVisible = !_isNewPasswordVisible),
                            icon: Icon(_isNewPasswordVisible
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const Divider(),
                      Text(
                        'As there is no mechanism for retriving the password if forgoten .Please remeber the password.',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
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
      ),
    );
  }
}
