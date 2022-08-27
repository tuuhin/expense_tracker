import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _oldPassword;
  late TextEditingController _newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;

  void _changePassword() {
    if (_formKey.currentState!.validate()) {}
  }

  String? _validateOldPassword(String? value) {
    if (value?.isEmpty == true) {
      return 'Enter the old password';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value?.isEmpty == true) return 'Enter the new password';
    if (value != null && value.length <= 5) {
      return 'Enter at-least 5 characters';
    }
    return null;
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
      appBar: AppBar(
        title: Text('Change Password',
            style: Theme.of(context).textTheme.subtitle1),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
          child: Divider(),
        ),
      ),
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
                          icon: Icon(
                            _isOldPasswordVisible
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_outlined,
                          ),
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
                                : Icons.visibility_off_outlined)),
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
                primary: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(size.width, 50),
              ),
              onPressed: _changePassword,
              child: const Text('Change Password')),
        ),
      ),
    );
  }
}
