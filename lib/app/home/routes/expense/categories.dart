import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';

class ExpenseCategories extends StatefulWidget {
  final List<ExpenseCategoriesModel> categories;
  const ExpenseCategories({Key? key, required this.categories})
      : super(key: key);

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  void _postCallback(Duration _) async {
    // logger.fine("called");
    final GlobalKey<SliverAnimatedListState> key =
        context.read<ExpenseCategoriesCubit>().key;

    for (int i = 0; i < widget.categories.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100),
          () => key.currentState?.insertItem(i));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_postCallback);
  }

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<ExpenseCategoriesCubit>().key,
        itemBuilder: (context, index, animation) => SlideAndFadeTransition(
          animation: animation,
          child: ExpenseCategoryCard(category: widget.categories[index]),
        ),
      );
}
