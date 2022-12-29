import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';

class ExpenseCardTitleTile extends StatelessWidget {
  final ExpenseModel expense;
  final void Function()? onDelete;
  final void Function()? onUpdate;
  const ExpenseCardTitleTile({
    Key? key,
    required this.expense,
    this.onDelete,
    this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(toDate(expense.addedAt),
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
                  tooltip: 'delete-goal',
                  alignment: Alignment.center,
                  onPressed: onDelete,
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
