import 'package:flutter/material.dart';

class SignUpSplash extends CustomPainter {
  final Color color;
  final Color secondaryColor;
  SignUpSplash({required this.color, required this.secondaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    Path pathOne = Path()
      ..moveTo(size.width * 0.6, 0)
      ..quadraticBezierTo(
          size.width * 0.4, size.height * 0.15, 0, size.height * 0.2)
      ..lineTo(0, 0);

    canvas.drawPath(pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.fill;
    Path pathTwo = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * .75)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.9, size.width, size.height * 0.65)
      ..lineTo(size.width, size.height);
    canvas.drawPath(pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
