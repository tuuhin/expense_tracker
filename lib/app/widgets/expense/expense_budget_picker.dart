import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseBudgetPicker extends StatelessWidget {
  final BaseBudgetModel? selectedBudget;
  final ValueChanged<BaseBudgetModel?>? onChange;
  const ExpenseBudgetPicker({
    Key? key,
    required this.onChange,
    this.selectedBudget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BudgetModel>>(
        future: context.read<BudgetCubit>().cachedBudget(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return DropdownButtonFormField<BaseBudgetModel>(
                validator: (value) =>
                    value == null ? "A bugdet need to added" : null,
                value: selectedBudget,
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
                          style: selectedBudget == budget
                              ? Theme.of(context).textTheme.subtitle1
                              : Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 14),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChange);
          }
          return const CircularProgressIndicator();
        });
  }
}
