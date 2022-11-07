import 'package:expense_tracker/app/home/routes/route_builder.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/income/income_source_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeSourcePicker extends StatefulWidget {
  const IncomeSourcePicker({Key? key}) : super(key: key);

  @override
  State<IncomeSourcePicker> createState() => _IncomeSourcePickerState();
}

class _IncomeSourcePickerState extends State<IncomeSourcePicker> {
  final GlobalKey<SliverAnimatedListState> _sourcesKey =
      GlobalKey<SliverAnimatedListState>();

  late List<IncomeSourceModel> pickableSources;

  @override
  void initState() {
    super.initState();
    context.read<IncomeSourceCubit>().getIncomeSources();
    pickableSources = context.read<IncomeCubit>().allIncomeSources;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      for (final IncomeSourceModel item in pickableSources) {
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => _sourcesKey.currentState?.insertItem(
            pickableSources.indexOf(item),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pick sources',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
              const Text('🟦 represent secure sources'),
            ],
          ),
        ),
        SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            sliver: SliverAnimatedList(
              key: context.read<IncomeSourceCubit>().incomeListKey,
              itemBuilder: (context, index, animation) => FadeTransition(
                opacity: animation.drive<double>(opacity),
                child: IncomeSourcePickerTile(
                  source: pickableSources[index],
                ),
              ),
            )),
      ]),
    );
  }
}
