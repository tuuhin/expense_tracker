import 'package:flutter/material.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: _size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(height: 20),
            Text(
              'Loading',
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
