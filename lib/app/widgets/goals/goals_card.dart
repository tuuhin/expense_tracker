import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';
import '../widgets.dart';

class GoalsCard extends StatelessWidget {
  final GoalsModel goal;
  const GoalsCard({Key? key, required this.goal}) : super(key: key);

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
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (goal.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: goal.imageUrl!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover),
                    )
                  else
                    Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'No Image',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black12),
                        ),
                      ),
                    ),
                  const VerticalDivider(),
                  Expanded(
                    child: Column(
                      children: [
                        GoalCompletionIndicator(goal: goal),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(TextSpan(
                                  text: "Collected Amount: ",
                                  children: [
                                    TextSpan(text: '${goal.collected}')
                                  ])),
                              const Divider(),
                              Text.rich(TextSpan(
                                  text: "Total Price: ",
                                  children: [TextSpan(text: '${goal.price}')]))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
