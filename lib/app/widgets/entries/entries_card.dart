import 'package:flutter/material.dart';

import '../../../domain/models/entries_model.dart';

class EntriesCard extends StatelessWidget {
  final EntriesModel model;
  const EntriesCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
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
