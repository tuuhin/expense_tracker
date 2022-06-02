import 'package:expense_tracker/app/auth/auth.dart';
import 'package:flutter/material.dart';

class AuthTabWrapper extends StatefulWidget {
  const AuthTabWrapper({Key? key}) : super(key: key);

  @override
  State<AuthTabWrapper> createState() => _AuthTabWrapperState();
}

class _AuthTabWrapperState extends State<AuthTabWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        animationDuration: const Duration(milliseconds: 400),
        length: 3,
        vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: TabBarView(controller: _controller, children: [
        AuthHome(controller: _controller),
        SignInPage(controller: _controller),
        SignUpPage(controller: _controller),
      ]),
    );
  }
}
