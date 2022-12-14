import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class AuthHome extends StatefulWidget {
  final void Function() signInTab;
  final void Function() signUpTab;
  const AuthHome({super.key, required this.signInTab, required this.signUpTab});

  @override
  State<AuthHome> createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: AuthWrapperSplash(
                color: Theme.of(context).brightness == Brightness.light
                    ? SummerSplash.blueGreen
                    : MermaidLagoon.babyBlue,
                secondaryColor: Theme.of(context).brightness == Brightness.light
                    ? SummerSplash.blueGrotto
                    : MermaidLagoon.midnightBlue,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: _duration,
              child: Image.asset('assets/flaticons/monochrome.png'),
              builder: (context, value, child) => AnimatedPositioned(
                    duration: _duration,
                    bottom: 190 - value * 10,
                    left: value * 10,
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: value,
                        child: child),
                  )),
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: _duration,
                  child: Text(
                    'Expense Tracker',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                          letterSpacing: 1.2,
                        ),
                  ),
                  builder: (context, value, child) => AnimatedOpacity(
                      duration: _duration, opacity: value, child: child),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: _duration,
                  child: SizedBox(
                    width: size.width * .9,
                    child: Text(
                        'This product allows you to manage your income and expenses and return a statistical data ',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16)),
                  ),
                  builder: (context, value, child) => AnimatedOpacity(
                      opacity: value,
                      duration: const Duration(milliseconds: 500),
                      child: child),
                ),
                const SizedBox(height: kTextTabBarHeight * 2 + 20)
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: Size(size.width, 50),
                ),
                onPressed: widget.signInTab,
                child: Text('Sign In',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.white))),
            const Divider(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  fixedSize: Size(size.width, 50),
                ),
                onPressed: widget.signUpTab,
                child: Text('Register',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white))),
          ]),
        ),
      ),
    );
  }
}
