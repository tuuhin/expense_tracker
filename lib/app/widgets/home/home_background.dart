import 'package:flutter/material.dart';

class BackGroundDesign extends CustomPainter {
  final BuildContext context;

  BackGroundDesign(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Theme.of(context).cardColor
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(size.width * 0.65, size.height * 0.2, size.width * 0.45,
          size.height * 0.6, 0, size.height * 0.5)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
