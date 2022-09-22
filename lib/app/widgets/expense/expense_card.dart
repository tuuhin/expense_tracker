import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/utils/date_formaters.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatefulWidget {
  final ExpenseModel expense;
  final Color? backgroundColor;
  const ExpenseCard({
    Key? key,
    required this.expense,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  void _interActiveMode() => Navigator.of(context).push(
      appRouteBuilder(ViewExpenseReceipt(imageURL: widget.expense.imageURL!)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
      child: Card(
        color: widget.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.expense.title,
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Text(toDate(widget.expense.addedAt),
                  style: Theme.of(context).textTheme.caption),
              const Divider(),
              ...[
                if (widget.expense.desc != null &&
                    widget.expense.desc!.isNotEmpty)
                  Text.rich(
                    TextSpan(text: 'Description:', children: [
                      TextSpan(
                          text: widget.expense.desc!,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontStyle: FontStyle.italic))
                    ]),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontStyle: FontStyle.italic),
                  )
                // Text("${expense.desc!}", style: Theme.of(context).textTheme.caption),
              ],
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    ...[
                      if (widget.expense.imageURL != null) ...[
                        GestureDetector(
                          onTap: _interActiveMode,
                          child: Hero(
                            tag: UniqueKey(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                key: ValueKey(widget.expense.imageURL!),
                                progressIndicatorBuilder:
                                    (context, url, progress) => Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color.fromARGB(
                                            255, 220, 220, 220)
                                        : const Color.fromARGB(
                                            255, 118, 118, 118),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                ),
                                imageUrl: widget.expense.imageURL!,
                                alignment: Alignment.centerLeft,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider()
                      ]
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Item Price : ',
                              children: [
                                TextSpan(
                                  text: widget.expense.amount.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 220, 220, 220)
                                  : const Color.fromARGB(255, 118, 118, 118),
                            ),
                            child: Padding(
                              padding: widget.expense.imageURL == null
                                  ? const EdgeInsets.all(10.0)
                                  : const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Budget Information:'),
                                  const Divider(height: 1),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Title: ',
                                      children: [
                                        TextSpan(
                                            text: widget.expense.budget.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Expires on: ',
                                      children: [
                                        TextSpan(
                                            text: toSimpleDate(
                                                widget.expense.budget.tillDate),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Balance Left:',
                                      children: [
                                        TextSpan(
                                            text:
                                                '${widget.expense.budget.amount - widget.expense.budget.amountUsed}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (widget.expense.categories != null &&
                  widget.expense.categories!.isNotEmpty) ...[
                const Divider(),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ExpenseChips(
                        backgroundColor: index % 2 != 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        label: widget.expense.categories![index].title),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: widget.expense.categories!.length,
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
