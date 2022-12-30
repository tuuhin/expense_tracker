import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseBudgetPicker extends StatefulWidget {
  final BaseBudgetModel? selectedBudget;
  final ValueChanged<BaseBudgetModel?>? onChange;
  const ExpenseBudgetPicker({
    Key? key,
    required this.onChange,
    this.selectedBudget,
  }) : super(key: key);

  @override
  State<ExpenseBudgetPicker> createState() => _ExpenseBudgetPickerState();
}

class _ExpenseBudgetPickerState extends State<ExpenseBudgetPicker> {
  void _pushBudget() {
    Navigator.of(context).pop();
    context.push('/budgets');
  }

  void _onPressed() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No budget found'),
          content: const Text(
              'A budget is mandatory during cretion of expesnse, add a budget then try to add your expense'),
          actions: [
            ElevatedButton(
                onPressed: _pushBudget, child: const Text('Add budget'))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => FutureBuilder<List<BudgetModel>>(
        future: context.read<BudgetCubit>().cachedBudget(),
        builder: (context, snapshot) =>
            (snapshot.hasData && snapshot.data != null)
                ? snapshot.data!.isEmpty
                    ? TextButton(
                        onPressed: _onPressed,
                        child: Text('No budget found',
                            style: Theme.of(context).textTheme.subtitle1))
                    : DropdownButtonFormField<BaseBudgetModel>(
                        validator: (value) =>
                            value == null ? "A bugdet need to added" : null,
                        value: widget.selectedBudget,
                        isExpanded: true,
                        hint: const Text('Pick a Budget'),
                        borderRadius: BorderRadius.circular(10),
                        alignment: Alignment.center,
                        decoration: const InputDecoration(helperText: "Budget"),
                        items: snapshot.data!
                            .map((e) => e.toBaseModel())
                            .map<DropdownMenuItem<BaseBudgetModel>>(
                              (BaseBudgetModel budget) => DropdownMenuItem(
                                value: budget,
                                child: Text(
                                  budget.title.toUpperCase(),
                                  style: widget.selectedBudget == budget
                                      ? Theme.of(context).textTheme.subtitle1
                                      : Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: widget.onChange)
                : const CircularProgressIndicator(),
      );
}
