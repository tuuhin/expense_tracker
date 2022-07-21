import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../context/income/income_source_notifier.dart';
import 'income_chips.dart';

class IncomeSourceGrid extends StatelessWidget {
  const IncomeSourceGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<IncomeCubit>().notifier,
      builder: (context, child) {
        IncomeSourceNotifier notifier = context.read<IncomeCubit>().notifier;
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
              onDelete: () => notifier.checkSource(notifier.sources[index]),
            ),
          ),
        );
      },
    );
  }
}
