import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:go_router/go_router.dart";

import '../../../../domain/models/models.dart';
import './expenses.dart';
import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';

class ShowExpenses extends StatefulWidget {
  const ShowExpenses({Key? key}) : super(key: key);

  @override
  State<ShowExpenses> createState() => _ShowExpensesState();
}

class _ShowExpensesState extends State<ShowExpenses> {
  void _addExpense() => context.push("/create-expense");

  @override
  void initState() {
    super.initState();
    context.read<ExpenseCubit>().getExpenses();
  }

  Future<void> _refresh() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Refresh data'),
          content: const Text('Refresh your expenses'),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => context
                  .read<ExpenseCubit>()
                  .getExpenses()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body:
          BlocListener<UiEventCubit<ExpenseModel>, UiEventState<ExpenseModel>>(
        bloc: context.read<ExpenseCubit>().uiEvent,
        listener: (context, state) => state.whenOrNull(
          showSnackBar: (message, data) => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            ),
          showDialog: (message, content, data) => showDialog(
              context: context,
              builder: (context) =>
                  UiEventDialog(title: message, content: content)),
        ),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  pinned: true,
                  title: const Text('Expenses'),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: BlocConsumer<ExpenseCubit, ExpenseState>(
                  listener: (context, state) => state.whenOrNull(
                    error: (errMessage, __) => ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(SnackBar(content: Text(errMessage))),
                  ),
                  builder: (context, state) => state.when(
                    loading: () => const LoadingShimmer(),
                    data: (data, _) => Expenses(expenses: data),
                    error: (errMessage, err) => SliverFillRemaining(
                        child: BaseError(message: errMessage, error: err)),
                    noData: (_) => NoDataWidget.expenses(),
                    errorWithData: (data, errMessage, err) =>
                        Expenses(expenses: data),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: 10 + kTextTabBarHeight))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, 50),
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onPressed: _addExpense,
          child: const Text('Add Expense'),
        ),
      ),
    );
  }
}
