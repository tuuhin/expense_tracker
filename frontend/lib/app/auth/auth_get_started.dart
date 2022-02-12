import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthGetStarted extends StatelessWidget {
  final TabController controller;
  const AuthGetStarted({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CustomPaint(painter: PaintSplash())),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            top: 150,
            right: -30,
            child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/flaticons/monochrome.png',
                  scale: 1.5,
                )),
          ),
          Positioned(
              bottom: 190,
              left: 10,
              child: Text(
                'Expense Tracker',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
              )),
          Positioned(
              bottom: 150,
              left: 10,
              child: Text(
                  'This product allows you to manage your income and \nexpenses and return a statistical data ',
                  style: Theme.of(context).textTheme.caption)),
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
                          fixedSize: Size(_screenWidth, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () =>
                          controller.animateTo(1, curve: Curves.easeInOut),
                      child: Text('Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))),
                  const Divider(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          primary: Theme.of(context).colorScheme.secondary,
                          fixedSize: Size(_screenWidth, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () =>
                          controller.animateTo(2, curve: Curves.easeInOut),
                      child: Text('Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
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

class PaintSplash extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    Path _pathOne = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..cubicTo(size.width * 0.65, size.height * 0.35, size.width * 0.5,
          size.height * 0.7, 0, size.height * 0.35)
      ..lineTo(0, 0);

    canvas.drawPath(_pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = const Color(0xff7fc3dc)
      ..style = PaintingStyle.fill;
    Path _pathTwo = Path()
      ..moveTo(size.width * .25, size.height)
      ..cubicTo(size.width * 0.45, size.height * .9, size.width * 0.7,
          size.height * .96, size.width, size.height * 0.9)
      ..lineTo(size.width, size.height);
    canvas.drawPath(_pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
