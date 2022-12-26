import 'package:flutter/material.dart';

import '../../../utils/validators.dart';

class UserProfileForm extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController phoneNumber;
  const UserProfileForm({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Personal Information',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) => value != null && value.isEmpty
                  ? "Cannot attach a blank field"
                  : null,
              controller: firstName,
              decoration: const InputDecoration(
                label: Text('First Name'),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) => value != null && value.isEmpty
                  ? "Cannot attach a blank field"
                  : null,
              controller: lastName,
              decoration: const InputDecoration(
                  label: Text('Last  Name'),
                  prefixIcon: Icon(Icons.person_outline)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) => value != null && value.isNotEmpty
                  ? validateEmail(value)
                      ? "INvalid email"
                      : null
                  : null,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  label: Text('Email'), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) => value != null && value.isNotEmpty
                  ? int.tryParse(value) == null
                      ? "a phone numbers  contains only numbers"
                      : null
                  : null,
              controller: phoneNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  label: Text('Phone number'),
                  prefixIcon: Icon(Icons.phone_android_rounded)),
            ),
            const Spacer(),
          ],
        ));
  }
}
