import 'package:flutter/material.dart';

class AuthLoadingState extends StatelessWidget {
  const AuthLoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
