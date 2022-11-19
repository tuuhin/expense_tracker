import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';
import '../../utils/ui_helpers.dart';
import '../widgets.dart';

class ShowBudgetCard extends StatelessWidget {
  final BudgetModel model;
  const ShowBudgetCard({Key? key, required this.model}) : super(key: key);

  void _deleteBudget() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.title,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.poppins().fontFamily)),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: _deleteBudget,
                      icon: const Icon(Icons.delete_forever)),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: BudgetIndicator(
                      total: model.amount, used: model.amountUsed),
                ),
                Flexible(flex: 5, child: BudgetAmountData(budgetInfo: model))
              ],
            ),
            const SizedBox(height: 10),
            if (model.desc?.isNotEmpty == true) ...[
              Text('Description', style: Theme.of(context).textTheme.subtitle1),
              Text(model.desc!, style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 5)
            ],
            Text('Timeline', style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                minHeight: 8,
                backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                value: ratioFromDateTime(model.statedFrom, model.tillDate),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(toSimpleDate(model.statedFrom)),
                  Text(toSimpleDate(model.tillDate))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
