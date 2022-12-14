import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class SignInSplash extends CustomPainter {
  final Color color;
  final Color secondaryColor;
  SignInSplash({required this.color, required this.secondaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    Path pathOne = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(size.width * 0.65, size.height * 0.2, size.width * 0.45,
          size.height * 0.6, 0, size.height * 0.5)
      ..lineTo(0, 0);

    canvas.drawPath(pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.fill;
    Path pathTwo = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.9)
      ..cubicTo(size.width * 0.4, size.height * 0.9, size.width * .7,
          size.height * 0.7, size.width, size.height * .75)
      ..lineTo(size.width, size.height);
    canvas.drawPath(pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
