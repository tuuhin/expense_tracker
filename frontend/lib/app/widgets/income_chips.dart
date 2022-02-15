import 'package:flutter/material.dart';

class IncomeChips extends StatelessWidget {
  final String label;
  final void Function()? onDelete;
  const IncomeChips({Key? key, required this.label, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Chip(
        padding: const EdgeInsets.all(5),
        deleteIconColor: Colors.white,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(label,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.white)),
        onDeleted: onDelete,
      );
}
