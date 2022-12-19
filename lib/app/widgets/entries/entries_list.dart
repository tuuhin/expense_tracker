import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../widgets.dart';
import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../../home/routes/route_builder.dart';

class EntriesList extends StatefulWidget {
  final List<EntriesDataModel> data;

  const EntriesList({Key? key, required this.data}) : super(key: key);

  @override
  State<EntriesList> createState() => _EntriesListState();
}

class _EntriesListState extends State<EntriesList> {
  void itemLoader(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<EntriesBloc>().key;
    for (int i = 0; i < widget.data.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100),
          () => key.currentState?.insertItem(i));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(itemLoader);
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        sliver: SliverAnimatedList(
          key: context.read<EntriesBloc>().key,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation.drive(opacity),
              child: SizeTransition(
                sizeFactor: animation,
                child: EntriesCard(model: widget.data[index]),
              ),
            );
          },
        ),
      );
}
