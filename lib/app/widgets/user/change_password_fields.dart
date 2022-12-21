import 'package:flutter/material.dart';

class ChangePasswordFields extends StatefulWidget {
  final TextEditingController newController;
  final TextEditingController oldController;
  const ChangePasswordFields({
    Key? key,
    required this.newController,
    required this.oldController,
  }) : super(key: key);

  @override
  State<ChangePasswordFields> createState() => _ChangePasswordFieldsState();
}

class _ChangePasswordFieldsState extends State<ChangePasswordFields> {
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFormField(
          validator: _validateOldPassword,
          controller: widget.oldController,
          obscureText: !_isOldPasswordVisible,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key),
            hintText: 'Old Password',
            suffixIcon: IconButton(
              onPressed: () => setState(
                  () => _isOldPasswordVisible = !_isOldPasswordVisible),
              icon: Icon(_isOldPasswordVisible
                  ? Icons.visibility_sharp
                  : Icons.visibility_off_outlined),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          validator: _validateNewPassword,
          controller: widget.newController,
          obscureText: !_isNewPasswordVisible,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key),
            hintText: 'New Password',
            helperText: 'The password should be atleast of 5 characters',
            suffixIcon: IconButton(
              onPressed: () => setState(
                  () => _isNewPasswordVisible = !_isNewPasswordVisible),
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
    );
  }
}
