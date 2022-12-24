import 'package:flutter/material.dart';

import '../home/routes/route_builder.dart';

class SlideAndFadeTransition extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;
  const SlideAndFadeTransition({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  State<SlideAndFadeTransition> createState() => _SlideAndFadeTransitionState();
}

class _SlideAndFadeTransitionState extends State<SlideAndFadeTransition> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation.drive(opacity),
      child: SlideTransition(
          position: widget.animation.drive(offset), child: widget.child),
    );
  }
}
