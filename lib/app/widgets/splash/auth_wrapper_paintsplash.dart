import 'package:expense_tracker/utils/palette.dart';
import 'package:flutter/material.dart';

class AuthWrapperSplash extends CustomPainter {
  final BuildContext context;
  AuthWrapperSplash({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = Theme.of(context).brightness == Brightness.light
          ? SummerSplash.blueGrotto
          : MermaidLagoon.midnightBlue
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
      ..color = Theme.of(context).brightness == Brightness.light
          ? SummerSplash.blueGreen
          : MermaidLagoon.babyBlue
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
