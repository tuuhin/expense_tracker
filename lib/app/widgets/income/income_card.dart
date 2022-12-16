import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/income/income_cubit.dart';
import '../../../domain/models/income/income_models.dart';
import '../../../utils/date_formaters.dart';

class IncomeCard extends StatefulWidget {
  final IncomeModel income;
  const IncomeCard({
    Key? key,
    required this.income,
  }) : super(key: key);

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  void _deleteIncome() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text.rich(
            TextSpan(
              text: "Delete Income: ",
              style: Theme.of(context).textTheme.subtitle1,
              children: [
                TextSpan(
                    text: widget.income.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          content: Text(
              'This deleted income record cannot be restrored.Are you sure you want to remove it.',
              style: Theme.of(context).textTheme.bodyText2),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).errorColor),
              onPressed: () async => await context
                  .read<IncomeCubit>()
                  .deleteIncome(widget.income, widget: widget)
                  .then(Navigator.of(context).pop),
              child: const Text('Delete'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 10),
              trailing: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _deleteIncome,
                  icon: Icon(Icons.delete_outline,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              title: Text(widget.income.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(toDate(widget.income.addedAt)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Amount",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('${widget.income.amount}',
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ),
            ),
            if (widget.income.desc != null && widget.income.desc!.isNotEmpty)
              Text(
                widget.income.desc!,
                maxLines: 3,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              ),
            if (widget.income.sources.isNotEmpty) ...[
              const Divider(),
              const Text('Sources',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 40,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Chip(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: Text(widget.income.sources[index].title),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: widget.income.sources.length,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
