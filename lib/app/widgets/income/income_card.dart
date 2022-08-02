import 'package:expense_tracker/app/widgets/income/income_chips.dart';
import 'package:expense_tracker/domain/models/income/income_models.dart';
import 'package:expense_tracker/utils/date_formaters.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  final IncomeModel income;
  const IncomeCard({
    Key? key,
    required this.income,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              trailing: Text('${income.amount}',
                  style: Theme.of(context).textTheme.headline6),
              title: Text(income.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(toDate(income.addedAt)),
            ),
            if (income.desc != null && income.desc!.isNotEmpty) ...[
              Text(income.desc!)
            ],
            if (income.sources != null && income.sources!.isNotEmpty) ...[
              const Divider(),
              SizedBox(
                height: 30,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => IncomeChips(
                        backgroundColor: index % 2 != 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        label: income.sources![index]!.title),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: income.sources!.length),
              )
            ]
          ],
        ),
      ),
    );
  }
}
