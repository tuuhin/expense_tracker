import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCategoryCard extends StatefulWidget {
  final ExpenseCategoriesModel? category;
  const ExpenseCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ExpenseCategoryCard> createState() => _ExpenseCategoryCardState();
}

class _ExpenseCategoryCardState extends State<ExpenseCategoryCard> {
  void _removeCategory() => context
      .read<ExpenseCategoriesCubit>()
      .deleteExpenseCategory(widget.category!);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        trailing: IconButton(
            onPressed: _removeCategory,
            icon: const Icon(Icons.delete_outline),
            color: Colors.white),
        title: Text(widget.category!.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )),
        subtitle:
            widget.category!.desc != null && widget.category!.desc!.isNotEmpty
                ? Text(
                    widget.category!.desc ?? '',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : null,
      ),
    );
  }
}
