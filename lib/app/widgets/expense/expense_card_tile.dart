import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';

class ExpenseCardTile extends StatelessWidget {
  final ExpenseModel expense;

  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  const ExpenseCardTile({
    Key? key,
    required this.expense,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(toDate(expense.addedAt),
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
                onPressed: onUpdate,
                icon: Icon(Icons.update_sharp,
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
    );
  }
}
