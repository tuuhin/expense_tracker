import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/loading/list_loading_shimmer.dart';
import '../routes.dart';
import 'sources.dart';

class ShowIncomeSources extends StatefulWidget {
  const ShowIncomeSources({Key? key}) : super(key: key);

  @override
  State<ShowIncomeSources> createState() => _ShowIncomeSourcesState();
}

class _ShowIncomeSourcesState extends State<ShowIncomeSources> {
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
    context.read<IncomeSourceCubit>().getIncomeSources();
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
        child: BlocListener<UiEventCubit<IncomeSourceModel>,
            UiEventState<IncomeSourceModel>>(
          bloc: context.read<IncomeSourceCubit>().uiEvent,
          listener: (context, state) => state.whenOrNull(
            showSnackBar: (message, data) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message))),
            showDialog: (message, content, data) => showDialog(
              context: context,
              builder: (context) =>
                  UiEventDialog(title: message, content: content),
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const Text('Income Sources'),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Text('Incomes source helps to structure your incomes',
                      style: Theme.of(context).textTheme.caption),
                ),
              ),
              //  Sliverto
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: BlocConsumer<IncomeSourceCubit, IncomeSourceState>(
                  listener: (context, state) => state.whenOrNull(
                    error: (errMessage, _) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(errMessage))),
                    errorWithData: (errMessage, _, __) =>
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(errMessage))),
                  ),
                  builder: (context, state) => state.when(
                    loading: () => const ListLoadingShimmer(),
                    data: (data, _) => Sources(sources: data),
                    error: (errMessage, err) => SliverFillRemaining(
                        child: BaseError(message: errMessage, error: err)),
                    noData: (message) => NoDataWidget.sources(),
                    errorWithData: (_, __, data) => Sources(sources: data),
                  ),
                ),
              ),
            ],
          ),
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
