import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../widgets.dart';

class ExpenseCategoryPicker extends StatefulWidget {
  final List<ExpenseCategoriesModel> categories;
  const ExpenseCategoryPicker({Key? key, required this.categories})
      : super(key: key);

  @override
  State<ExpenseCategoryPicker> createState() => _ExpenseCategoryPickerState();
}

class _ExpenseCategoryPickerState extends State<ExpenseCategoryPicker> {
  final GlobalKey<SliverAnimatedListState> _sourcesKey =
      GlobalKey<SliverAnimatedListState>();

  void _addItems(Duration _) async {
    logger.fine(widget.categories);
    for (var i = 0; i < widget.categories.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200),
          () => _sourcesKey.currentState?.insertItem(i));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(_addItems);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: kTextTabBarHeight * .75,
          automaticallyImplyLeading: false,
          title: Text(
            'Pick categories',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverAnimatedList(
            key: _sourcesKey,
            itemBuilder: (context, index, animation) => SizeTransition(
              sizeFactor: animation,
              child:
                  ExpenseCategoryPickerTile(category: widget.categories[index]),
            ),
          ),
        ),
      ],
    );
  }
}
