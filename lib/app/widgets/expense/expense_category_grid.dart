import 'package:expense_tracker/app/widgets/income/income_chips.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/context/expense/expense_category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCategoryGrid extends StatelessWidget {
  const ExpenseCategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ExpenseCubit>().notifier,
      builder: (context, child) {
        ExpenseCategoryNotifier notifier =
            context.read<ExpenseCubit>().notifier;
        return GridView.builder(
          itemCount: notifier.sources.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) => GridTile(
            child: IncomeChips(
              backgroundColor: index % 2 != 0
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              label: notifier.sources[index].title,
              onDelete: () => notifier.checkCategory(notifier.sources[index]),
            ),
          ),
        );
      },
    );
  }
}
