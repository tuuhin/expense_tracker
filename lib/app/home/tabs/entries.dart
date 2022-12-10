import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../widgets/entries/entries_loading_card.dart';
import '../../widgets/widgets.dart';

class EntriesTab extends StatefulWidget {
  const EntriesTab({Key? key}) : super(key: key);

  @override
  State<EntriesTab> createState() => _EntriesTabState();
}

class _EntriesTabState extends State<EntriesTab> {
  late ScrollController _scrollController;

  void _scrollListener() async {
    double delta = MediaQuery.of(context).size.height * .2;
    if (_scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <=
        delta) {
      context.read<EntriesBloc>().fetchMore();
    }
  }

  Future<void> _refresh() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh Entries'),
        content: const Text('Refresh your entries from the begining '),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => context
                  .read<EntriesBloc>()
                  .refresh()
                  .then(Navigator.of(context).pop),
              child: Text('Refresh'))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scrollbar(
        controller: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              title: Text('Your Entries',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
            BlocBuilder<EntriesBloc, EntriesState>(
              builder: (context, state) => state.when(
                  loading: () => const SliverPadding(
                      padding: EdgeInsets.all(8.0),
                      sliver: EntriesLoadingCard()),
                  data: (data) => EntriesList(data: data),
                  error: (error) => const SliverFillRemaining(
                        child: Text('error'),
                      ),
                  loadMore: (data) => EntriesList(data: data),
                  errorLoadMore: (data, error) => EntriesList(data: data),
                  end: (data, message) => EntriesList(data: data)),
            ),
            BlocBuilder<EntriesBloc, EntriesState>(
              builder: (context, state) => state.maybeWhen(
                  orElse: () => const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      ),
                  loadMore: (data) => SliverToBoxAdapter(
                        child: Text('Loadmore'),
                      ),
                  errorLoadMore: (data, error) =>
                      SliverToBoxAdapter(child: Text('error')),
                  end: (data, message) =>
                      SliverToBoxAdapter(child: Text(message))),
            ),
          ],
        ),
      ),
    );
  }
}
