import 'package:expense_tracker/animate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text('Trying animation personally'),
          ),
          body: const SizedBox.expand(child: AnimateFile())),
    );
  }
}
