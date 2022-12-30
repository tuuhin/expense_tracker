import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../widgets.dart';

class IncomeSourcePicker extends StatefulWidget {
  const IncomeSourcePicker({Key? key}) : super(key: key);

  @override
  State<IncomeSourcePicker> createState() => _IncomeSourcePickerState();
}

class _IncomeSourcePickerState extends State<IncomeSourcePicker> {
  void _createSource() {
    Navigator.of(context).pop();
    context.push('/sources');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pick sources',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<IncomeSourceModel>>(
            future: context.read<IncomeCubit>().cachedSources,
            builder: (context, snapshot) => (snapshot.hasData &&
                    snapshot.data != null)
                ? CustomScrollView(
                    slivers: [
                      (snapshot.data!.isNotEmpty)
                          ? SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) => IncomeSourcePickerTile(
                                        source: snapshot.data![index]),
                                    childCount: snapshot.data!.length),
                              ),
                            )
                          : SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'No sources found',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try adding some',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              fixedSize: Size(size.width, 50),
            ),
            onPressed: _createSource,
            child: const Text('Add Source'),
          ),
        )
      ],
    );
  }
}
