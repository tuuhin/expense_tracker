import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class ExpenseCategoryGrid extends StatelessWidget {
  const ExpenseCategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: AnimatedBuilder(
          animation: context.read<ExpenseCubit>().notifier,
          builder: (context, child) => Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: context
                .read<ExpenseCubit>()
                .notifier
                .selected
                .asMap()
                .map<int, Widget>((key, e) => MapEntry(
                      key,
                      Chip(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.75),
                        label: Text(
                          e.title,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        deleteIconColor: Colors.white,
                        onDeleted: () =>
                            context.read<ExpenseCubit>().notifier.check(e),
                      ),
                    ))
                .values
                .toList(),
          ),
        ),
      );
}
