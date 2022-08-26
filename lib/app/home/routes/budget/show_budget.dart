import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/budget/budget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowBudget extends StatefulWidget {
  const ShowBudget({Key? key}) : super(key: key);

  @override
  State<ShowBudget> createState() => _ShowBudgetState();
}

class _ShowBudgetState extends State<ShowBudget> {
  late BudgetCubit _budgetCubit;

  void _addShowBudget() =>
      Navigator.of(context).push(appRouteBuilder(const CreateBudget()));

  @override
  void initState() {
    super.initState();
    _budgetCubit = BlocProvider.of<BudgetCubit>(context);
    _budgetCubit.getBudgetInfo();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowBudgets'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
          child: Divider(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<BudgetCubit, BudgetState>(
          builder: (context, state) {
            if (state is BudgetLoadSuccess) {
              return AnimatedList(
                key: _budgetCubit.key,
                itemBuilder: (context, index, animation) => FadeTransition(
                  opacity: animation,
                  child: ShowBudgetCard(model: state.data[index]),
                ),
              );
            }
            if (state is BudgetLoad) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                primary: Theme.of(context).colorScheme.secondary),
            onPressed: _addShowBudget,
            icon: const Icon(Icons.add),
            label: const Text('Add Budget'),
          ),
        ),
      ),
    );
  }
}
