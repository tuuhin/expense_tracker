import 'package:flutter/material.dart';

class IncomeChips extends StatelessWidget {
  final String label;
  final void Function()? onDelete;
  final Color? backgroundColor;
  const IncomeChips({
    Key? key,
    required this.label,
    this.onDelete,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.all(5),
      deleteIconColor: Colors.white,
      backgroundColor: backgroundColor,
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.white),
      ),
      onDeleted: onDelete,
    );
  }
}
