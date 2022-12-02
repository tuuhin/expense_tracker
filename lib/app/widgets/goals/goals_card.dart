import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';
import '../widgets.dart';

class GoalsCard extends StatelessWidget {
  final GoalsModel goal;
  const GoalsCard({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GoalCardHeadTile(goal: goal),
          const Divider(),
          if (goal.desc != null && goal.desc!.isNotEmpty)
            Text.rich(
              TextSpan(
                text: "Description: ",
                children: [
                  TextSpan(
                    text: goal.desc!,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.caption?.color),
                  )
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (goal.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl: goal.imageUrl!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover),
                  ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: "Price: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [TextSpan(text: goal.price.toString())],
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: Text.rich(
              TextSpan(
                  text: "Last Updated on: ",
                  children: [TextSpan(text: toSimpleDate(goal.updatedAt))]),
            ),
          )
        ],
      ),
    ));
  }
}
