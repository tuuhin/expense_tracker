import 'package:flutter/material.dart';

class EmptyList extends StatefulWidget {
  final Image image;
  final String? subtitle;
  final String title;
  const EmptyList({
    Key? key,
    required this.title,
    required this.image,
    this.subtitle,
  }) : super(key: key);

  @override
  State<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeTransition(
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.image,
            const SizedBox(height: 10),
            Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
            ...[
              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: Theme.of(context).textTheme.caption,
                )
            ]
          ],
        ),
      ),
    );
  }
}
