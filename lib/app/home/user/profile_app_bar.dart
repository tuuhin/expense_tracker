import 'package:flutter/material.dart';

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Widget child;
  void Function()? onPressed;
  CustomAppBarDelegate({
    required this.child,
    this.onPressed,
    this.expandedHeight = 200,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: (maxExtent - shrinkOffset) / maxExtent,
          child: child,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          child: AppBar(
              backgroundColor: (maxExtent - shrinkOffset) / maxExtent == 0
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).appBarTheme.backgroundColor,
              flexibleSpace: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: 1 - ((maxExtent - shrinkOffset) / maxExtent),
                // child: SafeArea(
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       left: 40,
                //     ),
                //     child: ListTile(
                //       leading: ClipOval(child: child),
                //     ),
                //   ),
                // ),
              )),
        ),
        Positioned(
            right: 10,
            bottom: -20,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 600),
              scale: (maxExtent - shrinkOffset) / maxExtent > 0.6 ? 1 : 0,
              child: FloatingActionButton(
                heroTag: 'profile_image_picker',
                onPressed: onPressed,
                child: const Icon(Icons.photo_library_rounded,
                    color: Colors.white),
              ),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
