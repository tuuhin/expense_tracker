import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';
import '../../utils/ui_helpers.dart';
import '../widgets.dart';

class ShowBudgetCard extends StatefulWidget {
  final BudgetModel model;
  const ShowBudgetCard({Key? key, required this.model}) : super(key: key);

  @override
  State<ShowBudgetCard> createState() => _ShowBudgetCardState();
}

class _ShowBudgetCardState extends State<ShowBudgetCard> {
  void _deleteBudget() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Budget'),
          content: const Text('Either it\'s assocaited with no expenses '),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).errorColor),
                onPressed: () => context
                    .read<BudgetCubit>()
                    .deleteBudget(widget.model, widget: widget)
                    .then(Navigator.of(context).pop),
                child: const Text('Delete'))
          ],
        ),
      );

  void _updateBudget() =>
      context.push('/update-budget/${widget.model.id}', extra: widget.model);

  @override
  Widget build(BuildContext context) {
    final double ratio =
        ratioFromDateTime(widget.model.start, widget.model.end);
    return Card(
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BudgetTitleTile(
                model: widget.model,
                onDelete: _deleteBudget,
                onUpdate: _updateBudget),
            Row(
              children: [
                Flexible(flex: 3, child: BudgetIndicator(budget: widget.model)),
                Flexible(flex: 5, child: BudgetAmountData(budget: widget.model))
              ],
            ),
            if (widget.model.desc?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text('Description', style: Theme.of(context).textTheme.subtitle1),
              Text(widget.model.desc!,
                  style: Theme.of(context).textTheme.caption),
            ],
            if (!widget.model.hasExpired) ...[
              const SizedBox(height: 8),
              Text(
                'Timeline (${(ratio * 100).toStringAsFixed(2)}%)',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                    minHeight: 8,
                    backgroundColor: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.4),
                    value: ratio),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(toSimpleDate(widget.model.start)),
                    Text(toSimpleDate(widget.model.end))
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
