import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';

class EntriesCard extends StatelessWidget {
  final EntriesDataModel model;
  const EntriesCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.75)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      model.type.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6.0),
              if (model.desc != null && model.desc!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(model.desc!,
                      overflow: TextOverflow.ellipsis, maxLines: 4),
                )
            ],
          ),
        ),
      );
}
