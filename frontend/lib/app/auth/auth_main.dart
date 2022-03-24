import 'package:expense_tracker/app/auth/auth.dart';
import 'package:flutter/material.dart';

class AuthGetStarted extends StatelessWidget {
  final TabController controller;
  const AuthGetStarted({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    const Duration _animationDuration = Duration(milliseconds: 500);
    final OutlinedBorder _shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CustomPaint(painter: PaintSplash())),
          Positioned(
            top: 150,
            right: -30,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: _animationDuration,
                child:
                    Image.asset('assets/flaticons/monochrome.png', scale: 1.5),
                builder: (context, value, child) => AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value,
                    child: child)),
          ),
          Positioned(
              bottom: 200,
              left: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: _animationDuration,
                child: Text(
                  'Expense Tracker',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                builder: (context, double value, child) {
                  return AnimatedPadding(
                    padding: EdgeInsets.only(left: value * 10),
                    duration: _animationDuration,
                    child: AnimatedOpacity(
                        duration: _animationDuration,
                        opacity: value,
                        child: child),
                  );
                },
              )),
          Positioned(
              bottom: 160,
              left: 10,
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: _animationDuration,
                  child: Text(
                      'This product allows you to manage your income and \nexpenses and return a statistical data ',
                      style: Theme.of(context).textTheme.caption),
                  builder: (BuildContext context, double value, Widget? child) {
                    return AnimatedOpacity(
                        opacity: value,
                        duration: const Duration(milliseconds: 500),
                        child: child);
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          primary: Theme.of(context).colorScheme.primary,
                          fixedSize: Size(_screenX, 50),
                          shape: _shape),
                      onPressed: () =>
                          controller.animateTo(1, curve: Curves.easeInOut),
                      child: Text('Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))),
                  const Divider(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 4,
                          primary: Theme.of(context).colorScheme.secondary,
                          fixedSize: Size(_screenX, 50),
                          shape: _shape),
                      onPressed: () =>
                          controller.animateTo(2, curve: Curves.easeInOut),
                      child: Text('Register',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))),
                ]),
          )
        ],
      ),
    );
  }
}
