import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseCategoryGrid extends StatelessWidget {
  const ExpenseCategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ExpenseCubit>().notifier,
      builder: (context, child) {
        Notifier<ExpenseCategoriesModel> notifier =
            context.read<ExpenseCubit>().notifier;
        return GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: notifier.selected.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) => GridTile(
            child: Chip(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.75),
              label: Text(
                notifier.selected[index].title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              deleteIconColor: Colors.white,
              onDeleted: () => notifier.check(notifier.selected[index]),
            ),
          ),
        );
      },
    );
  }
}
