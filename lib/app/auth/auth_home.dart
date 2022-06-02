import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/utils/app_images.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHome extends StatefulWidget {
  final TabController controller;
  const AuthHome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AuthHome> createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SizedBox.expand(
              child: CustomPaint(
            painter: AuthWrapperSplash(context: context),
          )),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: _duration,
              child: authHomeImage,
              builder: (context, value, child) => AnimatedPositioned(
                    duration: _duration,
                    bottom: 190 - value * 10,
                    left: value * 10,
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: value,
                        child: child),
                  )),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: _duration,
            child: Text('Expense Tracker',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                    )),
            builder: (context, double value, child) {
              return AnimatedPositioned(
                duration: _duration,
                bottom: 190,
                left: value * 10,
                child: AnimatedOpacity(
                    duration: _duration, opacity: value, child: child),
              );
            },
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: _duration,
              child: SizedBox(
                width: _size.width * .9,
                child: Text(
                    'This product allows you to manage your income and expenses and return a statistical data ',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 16)),
              ),
              builder: (BuildContext context, double value, Widget? child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: 135,
                  left: value * 10,
                  child: AnimatedOpacity(
                      opacity: value,
                      duration: const Duration(milliseconds: 500),
                      child: child),
                );
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    fixedSize: Size(_size.width, 50),
                  ),
                  onPressed: () =>
                      widget.controller.animateTo(1, curve: Curves.easeInOut),
                  child: Text('Sign In',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white))),
              const Divider(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(_size.width, 50),
                  ),
                  onPressed: () =>
                      widget.controller.animateTo(2, curve: Curves.easeInOut),
                  child: Text('Register',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white))),
            ]),
          )),
    );
  }
}
