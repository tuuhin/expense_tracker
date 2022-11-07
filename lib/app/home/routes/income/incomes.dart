import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/income/income_models.dart';
import '../../../widgets/income/income_card.dart';
import '../route_builder.dart';

class Incomes extends StatelessWidget {
  final List<IncomeModel> models;
  const Incomes({Key? key, required this.models}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<IncomeCubit>().key,
        itemBuilder: (context, index, animation) => SlideTransition(
          position: animation.drive<Offset>(offset),
          child: FadeTransition(
            opacity: animation.drive<double>(opacity),
            child: IncomeCard(
              income: models[index],
            ),
          ),
        ),
      );
}
