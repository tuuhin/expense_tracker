import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/models.dart';
import '../widgets.dart';

class ExpenseCategoryPicker extends StatefulWidget {
  const ExpenseCategoryPicker({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryPicker> createState() => _ExpenseCategoryPickerState();
}

class _ExpenseCategoryPickerState extends State<ExpenseCategoryPicker> {
  void _createSource() {
    Navigator.of(context).pop();
    context.push('/categories');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pick Categories',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ExpenseCategoriesModel>>(
            future: context.read<ExpenseCubit>().cahedCategories,
            builder: (context, snapshot) => (snapshot.hasData &&
                    snapshot.data != null)
                ? CustomScrollView(
                    slivers: [
                      (snapshot.data!.isNotEmpty)
                          ? SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) => ExpenseCategoryPickerTile(
                                      category: snapshot.data![index]),
                                  childCount: snapshot.data!.length,
                                ),
                              ),
                            )
                          : SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'No sources found',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try adding some',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              fixedSize: Size(size.width, 50),
            ),
            onPressed: _createSource,
            child: const Text('Add Categories'),
          ),
        )
      ],
    );
  }
}
