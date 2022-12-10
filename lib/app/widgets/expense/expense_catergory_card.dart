import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class ExpenseCategoryCard extends StatefulWidget {
  final ExpenseCategoriesModel category;
  const ExpenseCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ExpenseCategoryCard> createState() => _ExpenseCategoryCardState();
}

class _ExpenseCategoryCardState extends State<ExpenseCategoryCard> {
  Future<void> _removeCategory() async => context
      .read<ExpenseCategoriesCubit>()
      .removeCategory(widget.category, widget: widget)
      .then(Navigator.of(context).pop);

  void _removeCateoryDialog() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text.rich(
            TextSpan(text: 'Delete Category:', children: [
              TextSpan(
                  text: widget.category.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))
            ]),
          ),
          content: const Text(
              'Deleting this category will remove this category from the associated expenses'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 0,
                side: const BorderSide(color: Colors.redAccent),
              ),
              onPressed: _removeCategory,
              child: const Text('Delete',
                  style: TextStyle(color: Colors.redAccent)),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.primary,
        child: ListTile(
          minVerticalPadding: 16,
          trailing: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                alignment: Alignment.center,
                onPressed: _removeCateoryDialog,
                icon: const Icon(Icons.delete_outline)),
          ),
          title: Text(widget.category.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
          subtitle: widget.category.desc?.isNotEmpty == true
              ? Text(widget.category.desc ?? '',
                  style: const TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2)
              : null,
        ),
      );
}
