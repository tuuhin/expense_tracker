import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/goals/goals_bloc.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/goals/goals_card.dart';

class GoalsList extends StatelessWidget {
  final List<GoalsModel> goals;
  const GoalsList({
    Key? key,
    required this.goals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverAnimatedList(
        key: context.read<GoalsBloc>().key,
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: GoalsCard(goal: goals[index]),
        ),
      ),
    );
  }
}
