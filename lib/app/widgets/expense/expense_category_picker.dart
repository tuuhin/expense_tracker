import 'package:expense_tracker/app/home/routes/route_builder.dart';
import 'package:expense_tracker/app/widgets/expense/expense_catergory_picker_tile.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCategoryPicker extends StatefulWidget {
  const ExpenseCategoryPicker({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryPicker> createState() => _ExpenseCategoryPickerState();
}

class _ExpenseCategoryPickerState extends State<ExpenseCategoryPicker> {
  late ExpenseCategoriesCubit _expenseCategoriesCubit;
  @override
  void initState() {
    super.initState();
    _expenseCategoriesCubit = BlocProvider.of<ExpenseCategoriesCubit>(context);
    _expenseCategoriesCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ExpenseCategoriesCubit, ExpenseCategoryState>(
        builder: (context, state) {
          if (state is ExpenseCategoryStateSuccess) {
            return Column(
              children: [
                Text('Pick Sources',
                    style: Theme.of(context).textTheme.headline6),
                const Divider(),
                Expanded(
                  child: AnimatedList(
                    key: _expenseCategoriesCubit.expenseSourceListKey,
                    itemBuilder: (context, index, animation) => FadeTransition(
                        opacity: animation.drive<double>(opacity),
                        child: ExpenseCategoryPickerTile(
                          category: state.data![index]!,
                        )),
                  ),
                ),
              ],
            );
          }
          if (state is ExpenseCategoryStateFailed) {
            return Container(height: 200, color: Colors.red);
          }
          return Column(
            children: [
              const Divider(height: 1),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              Text('Fetching results',
                  style: Theme.of(context).textTheme.caption),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
