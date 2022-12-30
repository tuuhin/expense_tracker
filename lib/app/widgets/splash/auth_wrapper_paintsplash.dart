import 'package:flutter/material.dart';

class AuthWrapperSplash extends CustomPainter {
  final Color color;
  final Color secondaryColor;
  AuthWrapperSplash({required this.color, required this.secondaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    Path pathOne = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..cubicTo(size.width * 0.65, size.height * 0.35, size.width * 0.5,
          size.height * 0.7, 0, size.height * 0.35)
      ..lineTo(0, 0);

    canvas.drawPath(pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.fill;
    Path pathTwo = Path()
      ..moveTo(size.width * .25, size.height)
      ..cubicTo(size.width * 0.45, size.height * .9, size.width * 0.7,
          size.height * .96, size.width, size.height * 0.9)
      ..lineTo(size.width, size.height);
    canvas.drawPath(pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
