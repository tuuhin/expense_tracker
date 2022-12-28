import 'package:flutter/material.dart';

class RouteHelperPersistanceHeader extends SliverPersistentHeaderDelegate {
  final String text;
  final TextStyle? style;

  RouteHelperPersistanceHeader({required this.text, this.style});
  @override
  Widget build(context, shrinkOffset, overlapsContent) => AnimatedOpacity(
      opacity: 1 - (shrinkOffset / maxExtent),
      curve: Curves.bounceInOut,
      duration: const Duration(microseconds: 7000),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text, style: style, textAlign: TextAlign.center)));

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight * .5;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
