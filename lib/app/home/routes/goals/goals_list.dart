import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/goals/goals_bloc.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/goals/goals_card.dart';

class GoalsList extends StatefulWidget {
  final List<GoalsModel> goals;
  const GoalsList({Key? key, required this.goals}) : super(key: key);

  @override
  State<GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList> {
  void _postFrameCallBack(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<GoalsBloc>().key;

    for (int i = 0; i < widget.goals.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50),
          () => key.currentState?.insertItem(0));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallBack);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverAnimatedList(
        key: context.read<GoalsBloc>().key,
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: GoalsCard(goal: widget.goals[index]),
        ),
      ),
    );
  }
}
