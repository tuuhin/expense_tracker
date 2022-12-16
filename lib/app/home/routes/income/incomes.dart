import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';

class Incomes extends StatefulWidget {
  final List<IncomeModel> incomes;
  const Incomes({Key? key, required this.incomes}) : super(key: key);

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> {
  void _postCallback(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<IncomeCubit>().key;

    for (int i = 0; i < widget.incomes.length; i++) {
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
        key: context.read<IncomeCubit>().key,
        itemBuilder: (context, index, animation) => SlideAndFadeTransition(
          animation: animation,
          child: IncomeCard(income: widget.incomes[index]),
        ),
      );
}
