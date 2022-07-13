import 'package:flutter/material.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [TextField(), TextField(), TextField()],
        ),
      ),
    );
  }
}
