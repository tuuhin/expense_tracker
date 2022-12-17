import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';
import '../routes.dart';
import './categories.dart';

class ShowExpenseCategories extends StatefulWidget {
  const ShowExpenseCategories({Key? key}) : super(key: key);

  @override
  State<ShowExpenseCategories> createState() => _ShowExpenseCategoriesState();
}

class _ShowExpenseCategoriesState extends State<ShowExpenseCategories> {
  void _addCategory() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const CreateCategory()),
      );

  Future<void> _onRefresh() async => await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Refresh'),
          content: const Text('Refresh your expense categories'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () => context
                  .read<ExpenseCategoriesCubit>()
                  .getCategories()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'),
            )
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    context.read<ExpenseCategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocListener<UiEventCubit<ExpenseCategoriesModel>,
            UiEventState<ExpenseCategoriesModel>>(
          bloc: context.read<ExpenseCategoriesCubit>().uiEvent,
          listener: (context, state) => state.whenOrNull(
            showDialog: (message, content, _) => showDialog(
                context: context,
                builder: (context) =>
                    UiEventDialog(title: message, content: content)),
            showSnackBar: (message, _) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message))),
          ),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(pinned: true, title: Text('Categories')),
              SliverToBoxAdapter(
                child: Text(
                  'Categories help you to organize the your expense data ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver:
                    BlocConsumer<ExpenseCategoriesCubit, ExpenseCategoryState>(
                  buildWhen: (previous, current) => previous != current,
                  listener: (context, state) => state.whenOrNull(
                    error: (errMessage, _) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errMessage)),
                    ),
                  ),
                  builder: (context, state) => state.when(
                    loading: () => const LoadingShimmer(),
                    noData: (_) =>
                        SliverFillRemaining(child: NoDataWidget.categories()),
                    data: (data, message) =>
                        ExpenseCategories(categories: data),
                    error: (errMessage, err) => SliverFillRemaining(
                        child: BaseError(message: errMessage, error: err)),
                    errorWithData: (errMessage, err, data) =>
                        ExpenseCategories(categories: data),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width, 50),
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              onPressed: _addCategory,
              child: const Text('Add Category')),
        ),
      ),
    );
  }
}
