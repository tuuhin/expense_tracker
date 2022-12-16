import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseCategoryPickerTile extends StatefulWidget {
  final ExpenseCategoriesModel category;
  const ExpenseCategoryPickerTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ExpenseCategoryPickerTile> createState() =>
      _ExpenseCategoryPickerState();
}

class _ExpenseCategoryPickerState extends State<ExpenseCategoryPickerTile> {
  late Notifier<ExpenseCategoriesModel> _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notifier = BlocProvider.of<ExpenseCubit>(context).notifier;
  }

  void onCheck(bool? check) => setState(() => _notifier.check(widget.category));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
        child: CheckboxListTile(
          value: _notifier.isThere(widget.category),
          onChanged: onCheck,
          title: Text(widget.category.title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: widget.category.desc != null
              ? Text(
                  widget.category.desc!,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              : null,
        ),
      ),
    );
  }
}
