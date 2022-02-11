import 'package:flutter/material.dart';

class AuthGetStarted extends StatelessWidget {
  const AuthGetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CustomPaint(painter: PaintSplash())),
          Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                'Get Staterd',
                style: Theme.of(context).textTheme.headline4,
              )),
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
      ..color = const Color(0xff3b3dbf)
      ..style = PaintingStyle.fill;

    Path _pathOne = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.75, size.width, size.height * 0.8)
      ..lineTo(size.width, size.height);
    canvas.drawPath(_pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = const Color(0xff7fc3dc)
      ..style = PaintingStyle.fill;
    Path _pathTwo = Path()
      ..moveTo(size.width, 0)
      ..cubicTo(size.width * 0.9, size.height * 0.2, size.width * 0.7,
          size.height * 0.1, size.width * 0.5, size.height * 0.3)
      ..cubicTo(size.width * 0.4, size.height * 0.4, size.width * 0.25,
          size.height * 0.5, size.width * 0, size.height * 0.7)
      ..lineTo(0, 0);
    canvas.drawPath(_pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
