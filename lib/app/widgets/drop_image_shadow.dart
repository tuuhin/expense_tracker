import 'dart:ui';

import 'package:flutter/material.dart';

class DropImageShadow extends StatelessWidget {
  final double scale;

  final Offset offset;

  final double borderRadius;

  final double blurRadius;

  final Image image;

  const DropImageShadow({
    Key? key,
    this.blurRadius = 8.0,
    this.borderRadius = 0.0,
    this.scale = 1.0,
    this.offset = const Offset(8.0, 8.0),
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      key: key,
      children: [
        Transform.translate(
          offset: offset,
          child: Transform.scale(
            scale: scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: image,
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(-5, -5),
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 4)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: image,
          ),
        )
      ],
    );
  }
}
