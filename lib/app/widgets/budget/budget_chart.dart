import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class BudgetChart extends CustomPainter {
  final Color? indicatorColor;

  final Color? dialColor;
  final double? width;
  final double? trackWidth;

  final double? radius;
  final double startAngle;
  final double sweepAngle;
  final Color? indicatorShadow;

  BudgetChart({
    this.startAngle = 180,
    this.sweepAngle = 180,
    this.trackWidth = 20,
    this.indicatorShadow = Colors.blueAccent,
    this.indicatorColor = Colors.blue,
    this.dialColor = Colors.grey,
    this.width = 20,
    this.radius = 60,
  })  : assert(trackWidth != 0 && trackWidth! >= width!),
        assert(width != 0);

  @override
  void paint(Canvas canvas, Size size) {
    assert(radius! < size.height * .5);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * .5, size.height * .5), radius: radius!),
        radians(180),
        radians(360),
        false,
        Paint()
          ..color = dialColor!
          ..strokeWidth = trackWidth!
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * .5, size.height * .5), radius: radius!),
        radians(startAngle + 180),
        radians(sweepAngle.toDouble()),
        false,
        Paint()
          ..color = indicatorShadow!
          ..strokeCap = StrokeCap.round
          ..strokeWidth = width!
          ..style = PaintingStyle.stroke
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * .5, size.height * .5), radius: radius!),
        radians(startAngle + 180),
        radians(sweepAngle.toDouble()),
        false,
        Paint()
          ..color = indicatorColor!
          ..strokeCap = StrokeCap.round
          ..strokeWidth = width!
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
