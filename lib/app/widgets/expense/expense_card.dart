import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets.dart';
import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseCard extends StatefulWidget {
  final ExpenseModel expense;

  const ExpenseCard({Key? key, required this.expense}) : super(key: key);

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  void _interActiveMode() => context.push('/preview/${widget.expense.id}',
      extra: widget.expense.imageURL);

  void _update() => context.push('/update-expense/${widget.expense.id}',
      extra: widget.expense);

  void _delete() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text.rich(
            TextSpan(
              text: 'Delete Expenses:',
              children: [
                TextSpan(
                    text: widget.expense.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
          ),
          content: const Text(
              'Although you can delete an expense it\'s always good to date the previous data'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 0,
                side: BorderSide(color: Theme.of(context).errorColor),
              ),
              onPressed: () => context
                  .read<ExpenseCubit>()
                  .deleteExpense(widget.expense, widget: widget)
                  .then(Navigator.of(context).pop),
              child: Text('Delete',
                  style: TextStyle(color: Theme.of(context).errorColor)),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpenseCardTile(
              expense: widget.expense,
              onDelete: _delete,
              onUpdate: _update,
            ),
            const Divider(),
            if (widget.expense.desc != null && widget.expense.desc!.isNotEmpty)
              Text.rich(
                TextSpan(text: 'Description:', children: [
                  TextSpan(
                    text: widget.expense.desc!,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ]),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  if (widget.expense.imageURL != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: _interActiveMode,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              Container(
                            decoration:
                                const BoxDecoration(color: Colors.black12),
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: progress.progress),
                            ),
                          ),
                          imageUrl: widget.expense.imageURL!,
                          alignment: Alignment.centerLeft,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/flaticons/no-photo.png',
                              width: 100, height: 100),
                        ],
                      ),
                    ),
                  const VerticalDivider(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text.rich(
                            TextSpan(
                              text: 'Amount: ',
                              children: [
                                TextSpan(
                                  text: widget.expense.amount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        ExpenseBudgetInfo(expense: widget.expense)
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (widget.expense.categories.isNotEmpty) ...[
              const Text('Categories',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 2),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) => ExpenseChips(
                      backgroundColor: idx % 2 != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      label: widget.expense.categories[idx].title),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 4),
                  itemCount: widget.expense.categories.length,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
