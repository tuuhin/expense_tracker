import 'package:flutter/material.dart';

class CreateGoals extends StatefulWidget {
  const CreateGoals({Key? key}) : super(key: key);

  @override
  State<CreateGoals> createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Goal'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
          child: Divider(),
        ),
      ),
    );
  }
}
