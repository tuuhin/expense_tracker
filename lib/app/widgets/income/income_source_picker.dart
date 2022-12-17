import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../widgets.dart';

class IncomeSourcePicker extends StatefulWidget {
  final List<IncomeSourceModel> sources;
  const IncomeSourcePicker({Key? key, required this.sources}) : super(key: key);

  @override
  State<IncomeSourcePicker> createState() => _IncomeSourcePickerState();
}

class _IncomeSourcePickerState extends State<IncomeSourcePicker> {
  final GlobalKey<SliverAnimatedListState> _sourcesKey =
      GlobalKey<SliverAnimatedListState>();

  void _addItems(Duration _) async {
    for (var i = 0; i < widget.sources.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200),
          () => _sourcesKey.currentState?.insertItem(i));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback(_addItems);
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
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverAnimatedList(
            key: _sourcesKey,
            itemBuilder: (context, index, animation) => SizeTransition(
              sizeFactor: animation,
              child: IncomeSourcePickerTile(source: widget.sources[index]),
            ),
          ),
        ),
      ],
    );
  }
}
