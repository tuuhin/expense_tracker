import 'package:flutter/material.dart';

class BackGroundDesign extends CustomPainter {
  final Color color;

  BackGroundDesign({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.fill;

    Path _path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(size.width * 0.65, size.height * 0.2, size.width * 0.45,
          size.height * 0.6, 0, size.height * 0.5)
      ..lineTo(0, 0);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
