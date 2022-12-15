import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
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
        title: const Text(
          'Refresh Entries',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Refresh your entries from the begining',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => context
                  .read<EntriesBloc>()
                  .refresh()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'))
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
              toolbarHeight: kTextTabBarHeight * 0.75,
              backgroundColor: Theme.of(context).cardColor,
              pinned: true,
              centerTitle: false,
              title: const Text(
                'Your Entries',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                    "Entries are the simplified versions of your income and expenses"),
              ),
            ),
            BlocConsumer<EntriesBloc, EntriesState>(
              listener: (context, state) => state.whenOrNull(),
              builder: (context, state) => state.when(
                  noData: (message) =>
                      SliverFillRemaining(child: NoDataWidget.entries()),
                  loading: () => const LoadingShimmer(),
                  data: (data) => EntriesList(data: data),
                  error: (error) => EntriesError(
                      onRefresh: context.read<EntriesBloc>().refresh),
                  loadMore: (data) => EntriesList(data: data),
                  errorLoadMore: (data, error) => EntriesList(data: data),
                  end: (data, message) => EntriesList(data: data)),
            ),
            BlocBuilder<EntriesBloc, EntriesState>(
              builder: (context, state) => state.maybeWhen(
                  orElse: () =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  loadMore: (data) => const PaginatorLoadMore(),
                  errorLoadMore: (data, error) =>
                      PaginatorLoadMoreFailed(message: error),
                  end: (data, message) => PaginatorEnd(message: message)),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20))
          ],
        ),
      ),
    );
  }
}
