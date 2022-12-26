import 'package:flutter/material.dart';

class BaseInformationCards extends StatefulWidget {
  final String title;
  final double amount;
  final Color? backGroundColor;

  const BaseInformationCards({
    Key? key,
    this.backGroundColor,
    required this.amount,
    required this.title,
  }) : super(key: key);

  @override
  State<BaseInformationCards> createState() => _BaseInformationCardsState();
}

class _BaseInformationCardsState extends State<BaseInformationCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scale = Tween<double>(begin: 0.4, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => FadeTransition(
        opacity: _controller,
        child: ScaleTransition(scale: _scale, child: child),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: size.width * .4,
        decoration: BoxDecoration(
          color: widget.backGroundColor?.withOpacity(0.9) ??
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: widget.backGroundColor == null
              ? Border.all(color: Theme.of(context).colorScheme.secondary)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            widget.backGroundColor == null
                ? Image.asset('assets/icons/wallet.png')
                : Image.asset(
                    "assets/icons/wallet-filled-money-tool.png",
                    color: Colors.white,
                  ),
            const SizedBox(height: 5),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: widget.backGroundColor != null
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.amount.toString(),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.backGroundColor != null
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
