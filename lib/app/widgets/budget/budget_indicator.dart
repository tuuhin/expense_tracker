import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../widgets.dart';

class BudgetIndicator extends StatefulWidget {
  final BudgetModel budget;

  const BudgetIndicator({Key? key, required this.budget}) : super(key: key);

  @override
  State<BudgetIndicator> createState() => _BudgetIndicatorState();
}

class _BudgetIndicatorState extends State<BudgetIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _amount;
  late Animation<double> _graph;
  late Animation<double> _scale;

  double get ratio => widget.budget.amountUsed / widget.budget.amount;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _amount = Tween<double>(begin: 0, end: ratio * 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
    _scale = Tween<double>(begin: 0.0, end: 1.25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _graph = Tween<double>(begin: 0.0, end: ratio * 270).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant BudgetIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool isChangeNeeded = oldWidget.budget.amount != widget.budget.amount ||
        oldWidget.budget.amountUsed != widget.budget.amountUsed;
    if (isChangeNeeded) {
      _amount = Tween<double>(begin: 0, end: ratio * 100).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate),
      );

      _graph = Tween<double>(begin: 0.0, end: ratio * 270).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 1, curve: Curves.easeIn),
        ),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            animation: _controller,
            builder: (context, _) => Transform.scale(
              scale: _scale.value,
              child: Text(
                "${(_amount.value).toStringAsFixed(1)}%",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              size: Size.infinite,
              foregroundPainter: BudgetChart(
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
