import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class Expenses extends StatefulWidget {
  final List<ExpenseModel> expenses;
  const Expenses({Key? key, required this.expenses}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _postCallback(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<ExpenseCubit>().key;

    for (int i = 0; i < widget.expenses.length; i++) {
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
        key: context.read<ExpenseCubit>().key,
        itemBuilder: (context, index, animation) {
          return SlideAndFadeTransition(
            animation: animation,
            child: ExpenseCard(expense: widget.expenses[index]),
          );
        },
      );
}
