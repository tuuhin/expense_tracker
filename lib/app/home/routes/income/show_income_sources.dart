import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/income/income_source_cubit.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/empty_list.dart';
import '../../../widgets/loading/list_loading_shimmer.dart';
import '../routes.dart';
import 'sources.dart';

class ShowIncomeSources extends StatefulWidget {
  const ShowIncomeSources({Key? key}) : super(key: key);

  @override
  State<ShowIncomeSources> createState() => _ShowIncomeSourcesState();
}

class _ShowIncomeSourcesState extends State<ShowIncomeSources> {
  late IncomeSourceCubit _incomeSourceCubit;
  void _addSource() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateSource(),
        ),
      );

  @override
  void initState() {
    super.initState();
    _incomeSourceCubit = BlocProvider.of<IncomeSourceCubit>(context);
    _incomeSourceCubit.getIncomeSources();
  }

  Future<void> _refreshData() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Refresh'),
          content: const Text('Refresh your income Sources'),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () => context
                  .read<IncomeSourceCubit>()
                  .getIncomeSources()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Income Sources'),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'Incomes source helps to structure your incomes',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            //  Sliverto
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: BlocConsumer<IncomeSourceCubit, IncomeSourceState>(
                listenWhen: (previous, current) =>
                    current is IncomeSourcesLoadFailed,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is IncomeSourcesLoadFailed && state.data != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is IncomeSourcesLoadSuccess) {
                    if (state.data.isNotEmpty) {
                      return Sources(models: state.data);
                    }
                    return SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          title: 'No income sources',
                          subtitle: 'You haven\'t add any income sources',
                          image: sadnessImage,
                        ),
                      ),
                    );
                  }
                  if (state is IncomeSourcesLoadFailed) {
                    if (state.data != null) {
                      return Sources(models: state.data!);
                    }
                    return SliverFillRemaining(
                        child: Container(height: 200, color: Colors.red));
                  } else {
                    return const ListLoadingShimmer();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, 50),
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onPressed: _addSource,
          child: const Text('Add Source'),
        ),
      ),
    );
  }
}
