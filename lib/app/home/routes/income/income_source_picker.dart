import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';

class IncomeSourcePicker extends StatefulWidget {
  const IncomeSourcePicker({Key? key}) : super(key: key);

  @override
  State<IncomeSourcePicker> createState() => _IncomeSourcePickerState();
}

class _IncomeSourcePickerState extends State<IncomeSourcePicker> {
  final GlobalKey<SliverAnimatedListState> _sourcesKey =
      GlobalKey<SliverAnimatedListState>();

  late List<IncomeSourceModel> _list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _list = context.read<IncomeCubit>().sources;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        for (var i = 0; i < _list.length; i++) {
          await Future.delayed(const Duration(milliseconds: 500),
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
              child: IncomeSourcePickerTile(source: _list[index]),
            ),
          ),
        ),
      ],
    );
  }
}
