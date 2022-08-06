import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:flutter/material.dart';

class EntriesCard extends StatelessWidget {
  final EntriesModel model;
  const EntriesCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: model.type == 'income'
          ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
          : Theme.of(context).colorScheme.secondary.withOpacity(0.9),
      child: ListTile(
        title: Text(model.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: model.desc != null && model.desc!.isNotEmpty
            ? Text(model.desc!, style: const TextStyle(color: Colors.white))
            : null,
      ),
    );
  }
}
