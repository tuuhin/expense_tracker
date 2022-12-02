import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/goals/goals_bloc.dart';
import '../routes.dart';
import 'goals_list.dart';

class ShowGoals extends StatefulWidget {
  const ShowGoals({Key? key}) : super(key: key);

  @override
  State<ShowGoals> createState() => _ShowGoalsState();
}

class _ShowGoalsState extends State<ShowGoals> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GoalsBloc>().fetchGoals();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addGoal() =>
      Navigator.of(context).push(appRouteBuilder(const CreateGoals()));
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        controller: _controller,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              title: const Text('Goals'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            BlocBuilder<GoalsBloc, GoalsState>(
              builder: (context, state) => state.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                success: (data, message) => GoalsList(goals: data),
                error: (message, data) => SliverFillRemaining(),
                blank: () => SliverFillRemaining(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            onPressed: _addGoal,
            child: const Text('Add Goal')),
      ),
    );
  }
}
