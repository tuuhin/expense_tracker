import 'package:expense_tracker/app/auth/sign_in.dart';
import 'package:expense_tracker/app/auth/sign_up.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<Widget> _screens = const [SignInPage(), SignUpPage(),];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: _controller, children: _screens),
    );
  }
}
