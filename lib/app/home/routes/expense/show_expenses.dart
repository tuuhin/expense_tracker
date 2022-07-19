import 'package:expense_tracker/app/home/routes/expense/create_expenses.dart';
import 'package:expense_tracker/app/home/routes/route_builder.dart';

import 'package:flutter/material.dart';

class ShowExpenses extends StatefulWidget {
  const ShowExpenses({Key? key}) : super(key: key);

  @override
  State<ShowExpenses> createState() => _ShowExpensesState();
}

class _ShowExpensesState extends State<ShowExpenses> {
  void _addExpense() =>
      Navigator.of(context).push(appRouteBuilder(const CreateExpense()));

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          // BlocBuilder<ExpenseCategoriesCubit, ExpenseCategoryState>(
          //   builder: (context, state) {
          //     print(state);
          //     if (state is ExpenseCategoryStateLoading) {
          //       return const CircularProgressIndicator();
          //     }

          //     return Container();
          //   },
          // ),
          Expanded(
            child: AnimatedList(
              itemBuilder: (context, index, animation) => const SizedBox(),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(_size.width, 50),
              primary: Theme.of(context).colorScheme.secondary),
          onPressed: _addExpense,
          child: const Text('Add Expense'),
        ),
      ),
    );
  }
}
