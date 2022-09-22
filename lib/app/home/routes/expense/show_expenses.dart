import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/utils/app_images.dart';

class ShowExpenses extends StatefulWidget {
  const ShowExpenses({Key? key}) : super(key: key);

  @override
  State<ShowExpenses> createState() => _ShowExpensesState();
}

class _ShowExpensesState extends State<ShowExpenses> {
  late ExpenseCubit _expenseCubit;

  void _addExpense() =>
      Navigator.of(context).push(appRouteBuilder(const CreateExpense()));

  @override
  void initState() {
    super.initState();
    _expenseCubit = BlocProvider.of<ExpenseCubit>(context);
    _expenseCubit.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
          child: Divider(),
        ),
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoadSuccess) {
            if (state.data!.isEmpty) {
              return Center(
                  child: EmptyList(
                title: 'Haven\'t you added your expense',
                subtitle: 'Did you forgot to add your data.',
                image: noMoneyImage,
              ));
            }
            return AnimatedList(
              key: _expenseCubit.key,
              itemBuilder: (context, index, animation) => FadeTransition(
                opacity: animation.drive(opacity),
                child: SlideTransition(
                  position: animation.drive(offset),
                  child: ExpenseCard(
                    expense: state.data![index],
                  ),
                ),
              ),
            );
          }

          if (state is ExpenseLoadFailed) {
            return Container(
              color: Colors.red,
              child: Text(state.message ?? ''),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
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
