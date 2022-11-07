import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';
import '../route_builder.dart';

class Sources extends StatelessWidget {
  final List<IncomeSourceModel> models;

  const Sources({
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<IncomeSourceCubit>().incomeListKey,
        itemBuilder: (context, index, animation) => SlideTransition(
          position: animation.drive<Offset>(offset),
          child: FadeTransition(
            opacity: animation.drive<double>(opacity),
            child: IncomeSourceCard(
              source: models[index],
            ),
          ),
        ),
      );
}
