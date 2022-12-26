import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: BackGroundDesign(color: Theme.of(context).cardColor),
      ),
    );
  }
}

class BackGroundDesign extends CustomPainter {
  final Color color;

  BackGroundDesign({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(
        size.width * 0.65,
        size.height * 0.2,
        size.width * 0.45,
        size.height * 0.6,
        0,
        size.height * 0.5,
      )
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
