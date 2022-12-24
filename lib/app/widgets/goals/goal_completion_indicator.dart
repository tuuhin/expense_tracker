import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import 'goal_chart.dart';

class GoalCompletionIndicator extends StatefulWidget {
  final GoalsModel goal;
  const GoalCompletionIndicator({Key? key, required this.goal})
      : super(key: key);

  @override
  State<GoalCompletionIndicator> createState() =>
      _GoalCompletionIndicatorState();
}

class _GoalCompletionIndicatorState extends State<GoalCompletionIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _amount;
  late Animation<double> _graph;
  late Animation<double> _scale;

  double get ratio => widget.goal.collected / widget.goal.price > 1
      ? 1
      : widget.goal.collected / widget.goal.price;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Transform.scale(
                scale: _scale.value,
                child: Text.rich(
                  TextSpan(
                    text: (_amount.value).toStringAsFixed(1),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                    children: const [
                      TextSpan(text: '%', style: TextStyle(fontSize: 12))
                    ],
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                size: const Size.square(200),
                painter: GoalsChart(
                  trackWidth: 14,
                  width: 14,
                  sweepAngle: _graph.value,
                  indicatorColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.75),
                  radius: 40,
                  dialColor: Colors.black12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
