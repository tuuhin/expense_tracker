import 'package:flutter/material.dart';

import '../../../utils/date_formaters.dart';
import '../../../domain/models/models.dart';

class ExpenseBudgetInfo extends StatelessWidget {
  final ExpenseModel expense;
  const ExpenseBudgetInfo({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget', style: Theme.of(context).textTheme.subtitle2),
            const Divider(),
            Text(
              expense.budget.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text.rich(
              TextSpan(
                text: 'Expires on: ',
                style: Theme.of(context).textTheme.caption,
                children: [
                  TextSpan(
                      text: toSimpleDate(expense.budget.start),
                      style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Balance Left: ',
                style: Theme.of(context).textTheme.caption,
                children: [
                  TextSpan(
                      text:
                          '${expense.budget.amount - expense.budget.amountUsed}',
                      style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
