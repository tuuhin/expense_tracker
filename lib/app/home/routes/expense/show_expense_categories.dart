import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';

class ShowExpenseCategories extends StatefulWidget {
  const ShowExpenseCategories({Key? key}) : super(key: key);

  @override
  State<ShowExpenseCategories> createState() => _ShowExpenseCategoriesState();
}

class _ShowExpenseCategoriesState extends State<ShowExpenseCategories> {
  late ExpenseCategoriesCubit _expenseCategoriesCubit;

  void _addCategory() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateCategory(),
        ),
      );

  @override
  void initState() {
    super.initState();
    _expenseCategoriesCubit = BlocProvider.of<ExpenseCategoriesCubit>(context);
    if (mounted) {
      _expenseCategoriesCubit.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Categories'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
            child: Divider(),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<ExpenseCategoriesCubit, ExpenseCategoryState>(
              builder: (context, state) {
                if (state is ExpenseCategoryStateSuccess) {
                  if (state.data!.isEmpty) {
                    return Center(
                        child: EmptyList(
                      title: 'No Expense Categories',
                      subtitle: 'You haven\'t add any expense categories',
                      image: sadnessImage,
                    ));
                  }
                  return AnimatedList(
                    key: _expenseCategoriesCubit.expenseSourceListKey,
                    itemBuilder: (context, index, animation) => SlideTransition(
                      position: animation.drive<Offset>(offset),
                      child: FadeTransition(
                        opacity: animation.drive<double>(opacity),
                        child: ExpenseCategoryCard(
                          category: state.data![index],
                        ),
                      ),
                    ),
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
            )),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width, 50),
                    primary: Theme.of(context).colorScheme.secondary),
                onPressed: _addCategory,
                child: const Text('Add Category')),
          ),
        ));
  }
}
