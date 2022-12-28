import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../context/context.dart';
import '../../../domain/models/goals/goals_model.dart';
import '../../../utils/date_formaters.dart';

class GoalCardHeadTile extends StatefulWidget {
  final GoalsModel goal;
  const GoalCardHeadTile({Key? key, required this.goal}) : super(key: key);

  @override
  State<GoalCardHeadTile> createState() => _GoalCardHeadTileState();
}

class _GoalCardHeadTileState extends State<GoalCardHeadTile> {
  void _onDelete() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete Goal"),
          content: Text(
              "Are you sure you want to delete goal titled :${widget.goal.title}"),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () => context
                    .read<GoalsBloc>()
                    .removeGoal(widget.goal, widget: widget)
                    .then(Navigator.of(context).pop),
                child: const Text("Delete"))
          ],
        ),
      );

  void _update() =>
      context.push('/update-goals/${widget.goal.id}', extra: widget.goal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.goal.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(toDate(widget.goal.createdAt),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: !widget.goal.accomplished ? _update : null,
                  icon: Icon(
                      widget.goal.accomplished ? Icons.check : Icons.update,
                      color: widget.goal.accomplished
                          ? Colors.green[800]
                          : Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  tooltip: 'delete-goal',
                  alignment: Alignment.center,
                  onPressed: _onDelete,
                  icon: Icon(Icons.delete_forever,
                      color: Theme.of(context).errorColor),
                ),
              ),
            ],
          )
        ],
      )
    ]);
  }
}
