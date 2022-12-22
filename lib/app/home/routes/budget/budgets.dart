import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../route_builder.dart';
import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class Budgets extends StatefulWidget {
  final List<BudgetModel> models;
  const Budgets({Key? key, required this.models}) : super(key: key);

  @override
  State<Budgets> createState() => _BudgetsState();
}

class _BudgetsState extends State<Budgets> {
  void _postFrameCallBack(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<BudgetCubit>().key;
    for (int i = 0; i < widget.models.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50),
          () => key.currentState?.insertItem(i));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallBack);
  }

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<BudgetCubit>().key,
        itemBuilder: (context, index, animation) => SlideTransition(
          position: animation.drive<Offset>(offset),
          child: FadeTransition(
            opacity: animation.drive<double>(opacity),
            child: ShowBudgetCard(model: widget.models[index]),
          ),
        ),
      );
}
