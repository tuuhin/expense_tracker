import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

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
    context.read<GoalsBloc>().fetchGoals();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Refresh Goals'),
          content: const Text('You can refresh your Goals'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('cancel')),
            ElevatedButton(
              onPressed: () => context
                  .read<GoalsBloc>()
                  .refreshGoals()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'),
            )
          ],
        ),
      );

  void _addGoal() => context.push('/create-goals');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<UiEventCubit<GoalsModel>, UiEventState<GoalsModel>>(
        bloc: context.read<GoalsBloc>().uiEvent,
        listener: (context, state) => state.whenOrNull(
          showSnackBar: (message, data) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
          showDialog: (message, content, data) => showDialog(
            context: context,
            builder: (context) =>
                UiEventDialog(title: message, content: content),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Scrollbar(
            controller: _controller,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              slivers: [
                SliverAppBar(
                    pinned: true,
                    title: const Text('Goals'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor),
                SliverPersistentHeader(
                  delegate: RouteHelperPersistanceHeader(
                    text:
                        'A goal is an aim or objective that you work toward with effort and determination',
                  ),
                ),
                BlocConsumer<GoalsBloc, GoalsState>(
                  listener: (context, state) => state.whenOrNull(),
                  builder: (context, state) => state.when(
                    loading: () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    data: (data, message) => GoalsList(goals: data),
                    error: (message, data) => const SliverFillRemaining(),
                    noData: (message) => NoDataWidget.goals(),
                    errorWithData: (error, message, data) =>
                        GoalsList(goals: data),
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: kTextTabBarHeight + 10))
              ],
            ),
          ),
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
