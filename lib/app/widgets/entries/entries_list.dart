import 'package:expense_tracker/app/widgets/entries/entries_loading_card.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/models.dart';
import '../../home/routes/route_builder.dart';
import '../widgets.dart';

class EntriesList extends StatelessWidget {
  final List<EntriesDataModel> data;

  const EntriesList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) => data.isEmpty
      ? const EntriesLoadingCard()
      : SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          sliver: SliverAnimatedList(
            key: context.read<EntriesBloc>().key,
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation.drive(opacity),
                child: SizeTransition(
                  sizeFactor: animation,
                  child: EntriesCard(model: data[index]),
                ),
              );
            },
          ),
        );
}
