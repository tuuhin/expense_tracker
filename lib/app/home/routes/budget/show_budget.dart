import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import './budgets.dart';
import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class ShowBudget extends StatefulWidget {
  const ShowBudget({Key? key}) : super(key: key);

  @override
  State<ShowBudget> createState() => _ShowBudgetState();
}

class _ShowBudgetState extends State<ShowBudget> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    context.read<BudgetCubit>().getBudgetInfo();
  }

  void _addShowBudget() => context.push('/create-budget');

  Future<void> _refreshData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh your Budgets'),
        content: const Text('You can refresh your budgets'),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => context
                .read<BudgetCubit>()
                .getBudgetInfo()
                .then(Navigator.of(context).pop),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Budgets')),
      extendBody: true,
      body: BlocListener<UiEventCubit<BudgetModel>, UiEventState<BudgetModel>>(
        bloc: context.read<BudgetCubit>().uievent,
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
          onRefresh: _refreshData,
          child: Scrollbar(
            controller: _controller,
            child: CustomScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'A budget hepls you to track the expenses ,it mainly acts as a limit that you cannot cross.',
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: BlocConsumer<BudgetCubit, BudgetState>(
                    listener: (context, state) => state.whenOrNull(
                      error: (_, message) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message))),
                      noData: (message) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message))),
                      errorWithData: (_, message, __) =>
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message))),
                    ),
                    builder: (context, state) => state.when(
                      loading: () => const LoadingShimmer(),
                      data: (data, message) => Budgets(models: data),
                      error: (error, message) => const SliverFillRemaining(
                          child: Center(child: Text('error'))),
                      noData: (message) =>
                          SliverFillRemaining(child: NoDataWidget.budget()),
                      errorWithData: (error, message, data) =>
                          Budgets(models: data),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: kTextTabBarHeight + 10))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            onPressed: _addShowBudget,
            icon: const Icon(Icons.add),
            label: const Text('Add Budget'),
          ),
        ),
      ),
    );
  }
}
