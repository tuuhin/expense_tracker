import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';

class BudgetAmountData extends StatelessWidget {
  final BudgetModel budgetInfo;
  const BudgetAmountData({Key? key, required this.budgetInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Amount'),
            const SizedBox(height: 2),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [Text('Total'), Text('Left'), Text('Used')],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text('${budgetInfo.amount}'),
                    Text('${budgetInfo.amount - budgetInfo.amountUsed}'),
                    Text('${budgetInfo.amountUsed}'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
