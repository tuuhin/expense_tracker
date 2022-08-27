import 'dart:ui';

import 'package:expense_tracker/app/widgets/budget/budget_chart.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:expense_tracker/utils/date_formaters.dart';
import 'package:flutter/material.dart';

class ShowBudgetCard extends StatefulWidget {
  final BudgetModel model;
  const ShowBudgetCard({Key? key, required this.model}) : super(key: key);

  @override
  State<ShowBudgetCard> createState() => _ShowBudgetCardState();
}

class _ShowBudgetCardState extends State<ShowBudgetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _amount;
  late Animation<double> _graph;
  late Animation<double> _scale;

  double get _chartFillAngle =>
      (widget.model.amountUsed / widget.model.amount * 360);

  double get _amountPercentage =>
      ((widget.model.amountUsed / widget.model.amount) * 100);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _amount = Tween<double>(begin: 0, end: _amountPercentage).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );
    _scale = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0.4, 1, curve: Curves.fastOutSlowIn)),
    );

    _graph = Tween<double>(begin: 0.0, end: _chartFillAngle).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, animation) => Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          Transform.scale(
                            scale: _scale.value,
                            child: Text("${_amount.value.toInt()}%",
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          CustomPaint(
                            size: const Size.fromHeight(120),
                            foregroundPainter: BudgetChart(
                              trackWidth: 15,
                              width: 15,
                              startAngle: 0,
                              sweepAngle: _graph.value,
                              indicatorColor:
                                  Theme.of(context).colorScheme.primary,
                              indicatorShadow:
                                  Theme.of(context).colorScheme.secondary,
                              radius: 50,
                              dialColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 220, 220, 220)
                                  : const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                        ],
                      )),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  ...[
                    if (widget.model.desc != null &&
                        widget.model.desc!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(widget.model.desc!,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis),
                      )
                    else
                      const SizedBox(height: 16)
                  ],
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 220, 220, 220)
                            : const Color.fromARGB(255, 118, 118, 118),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Range',
                              style: Theme.of(context).textTheme.caption),
                          Text(
                            toDate(widget.model.statedFrom),
                            style: Theme.of(context).textTheme.button,
                          ),
                          Text(
                            toDate(widget.model.tillDate),
                            style: Theme.of(context).textTheme.button,
                          ),
                          const Divider(),
                          Text('AmountLeft',
                              style: Theme.of(context).textTheme.caption),
                          Text(
                              '${widget.model.amount - widget.model.amountUsed}'),
                          Text('Amount Used',
                              style: Theme.of(context).textTheme.caption),
                          Text('${widget.model.amountUsed}'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
