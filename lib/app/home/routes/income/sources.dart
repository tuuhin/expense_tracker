import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';
import '../route_builder.dart';

class Sources extends StatefulWidget {
  final List<IncomeSourceModel> sources;

  const Sources({Key? key, required this.sources}) : super(key: key);

  @override
  State<Sources> createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  void _postCallback(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<IncomeSourceCubit>().incomeListKey;

    for (int i = 0; i < widget.sources.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100),
          () => key.currentState?.insertItem(i));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_postCallback);
  }

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<IncomeSourceCubit>().incomeListKey,
        itemBuilder: (context, index, animation) => SlideTransition(
          position: animation.drive<Offset>(offset),
          child: FadeTransition(
            opacity: animation.drive<double>(opacity),
            child: IncomeSourceCard(source: widget.sources[index]),
          ),
        ),
      );
}
