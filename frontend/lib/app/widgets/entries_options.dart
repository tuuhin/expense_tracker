import 'package:flutter/material.dart';

class EntriesOptions extends StatefulWidget {
  const EntriesOptions({Key? key}) : super(key: key);

  @override
  _EntriesOptionsState createState() => _EntriesOptionsState();
}

class _EntriesOptionsState extends State<EntriesOptions> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 250,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: const [0.0, 0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                Theme.of(context).colorScheme.primary
              ])),
    );
  }
}
