import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/goals/goals_model.dart';
import '../../../utils/date_formaters.dart';

class GoalCardHeadTile extends StatelessWidget {
  final GoalsModel goal;
  const GoalCardHeadTile({Key? key, required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goal.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(toDate(goal.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
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
                  onPressed: () {},
                  icon: Icon(goal.accomplished ? Icons.check : Icons.update,
                      color: goal.accomplished
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
                  onPressed: () {},
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
