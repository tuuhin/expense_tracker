import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/expense/expense_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late ExpenseCubit _incomeCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _incomeCubit = BlocProvider.of<ExpenseCubit>(context);
  }

  void onCheck(bool? check) =>
      setState(() => _incomeCubit.notifier.checkCategory(widget.category));
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: CheckboxListTile(
        value: _incomeCubit.notifier.categoryInList(widget.category),
        onChanged: onCheck,
        title: Text(widget.category.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: widget.category.desc != null
            ? Text(
                widget.category.desc!,
                style: const TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w400),
              )
            : null,
      ),
    );
  }
}
