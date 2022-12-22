import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';

class BudgetTitleTile extends StatelessWidget {
  final BudgetModel model;

  final void Function()? onDelete;
  final void Function()? onUpdate;
  const BudgetTitleTile({
    Key? key,
    required this.model,
    this.onDelete,
    this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(toDate(model.issedAt),
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
                  child: model.hasExpired
                      ? const Icon(Icons.check)
                      : IconButton(
                          alignment: Alignment.center,
                          onPressed: onUpdate,
                          icon: Icon(Icons.update,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: onDelete,
                    icon: Icon(Icons.delete_forever,
                        color: Theme.of(context).errorColor),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 4)
      ],
    );
  }
}
