import 'package:flutter/material.dart';

class BaseError extends StatelessWidget {
  final String message;
  final Object error;
  const BaseError({Key? key, required this.message, required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/flaticons/sadness.png'),
        const SizedBox(height: 10),
        Text('Error Occured ❗',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          message,
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
