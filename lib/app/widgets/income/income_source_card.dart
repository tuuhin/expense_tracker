import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class IncomeSourceCard extends StatefulWidget {
  final IncomeSourceModel source;

  const IncomeSourceCard({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  State<IncomeSourceCard> createState() => _IncomeSourceCardState();
}

class _IncomeSourceCardState extends State<IncomeSourceCard> {
  void _deleteSource() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Source ${widget.source.title}'),
          content: Text(
              'This source will be remove from all your income containing this source',
              style: Theme.of(context).textTheme.bodyText2),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).errorColor)),
              onPressed: () => context
                  .read<IncomeSourceCubit>()
                  .deleteSource(widget.source, widget: widget)
                  .then(Navigator.of(context).pop),
              child: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              strokeAlign: StrokeAlign.inside,
              width: 1.2),
        ),
        child: ListTile(
          trailing: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: _deleteSource,
              icon: const Icon(Icons.delete_outline, color: Colors.white),
            ),
          ),
          title: Text(
            widget.source.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.source.desc ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
