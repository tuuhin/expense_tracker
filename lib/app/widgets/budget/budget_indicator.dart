import 'package:flutter/material.dart';

import '../widgets.dart';

class BudgetIndicator extends StatefulWidget {
  final double total;
  final double used;

  const BudgetIndicator({
    Key? key,
    required this.total,
    required this.used,
  }) : super(key: key);

  @override
  State<BudgetIndicator> createState() => _BudgetIndicatorState();
}

class _BudgetIndicatorState extends State<BudgetIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _amount;
  late Animation<double> _graph;
  late Animation<double> _scale;

  double get _chartFillAngle => widget.used / widget.total * 360;

  double get _amountPercentage => (widget.used / widget.total) * 100;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _amount = Tween<double>(begin: 0, end: _amountPercentage).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );
    _scale = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceOut),
    );

    _graph = Tween<double>(begin: 0.0, end: _chartFillAngle).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.4, 1, curve: Curves.easeIn)));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, _) => Transform.scale(
              scale: _scale.value,
              child: Text("${_amount.value.toStringAsFixed(1)}%",
                  style: Theme.of(context).textTheme.headline6),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, _) => CustomPaint(
              size: Size.infinite,
              painter: BudgetChart(
                trackWidth: 12,
                width: 12,
                startAngle: 0,
                sweepAngle: _graph.value,
                indicatorColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.75),
                indicatorShadow:
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                radius: 40,
                dialColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black12
                    : Colors.white12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
