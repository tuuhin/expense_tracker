import 'package:expense_tracker/app/widgets/expense/expense_catergory_picker_tile.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/expense/expense_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCategoryPicker extends StatefulWidget {
  const ExpenseCategoryPicker({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryPicker> createState() => _ExpenseCategoryPickerState();
}

class _ExpenseCategoryPickerState extends State<ExpenseCategoryPicker> {
  final GlobalKey<SliverAnimatedListState> _sourcesKey =
      GlobalKey<SliverAnimatedListState>();

  late List<ExpenseCategoriesModel> _list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _list = context.read<ExpenseCubit>().categories;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        for (var i = 0; i < _list.length; i++) {
          await Future.delayed(const Duration(milliseconds: 200),
              () => _sourcesKey.currentState?.insertItem(i));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: kTextTabBarHeight * .75,
          automaticallyImplyLeading: false,
          title: Text(
            'Pick sources',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverAnimatedList(
            key: _sourcesKey,
            itemBuilder: (context, index, animation) => SizeTransition(
              sizeFactor: animation,
              child: ExpenseCategoryPickerTile(category: _list[index]),
            ),
          ),
        ),
      ],
    );
  }
}
