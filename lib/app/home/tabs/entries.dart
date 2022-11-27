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

  Future<void> itemLoader(Duration _) async {
    EntriesBloc bloc = context.read<EntriesBloc>();
    for (int i = 0; i < bloc.entriesCount; i++) {
      await Future.delayed(const Duration(milliseconds: 100),
          () => bloc.key.currentState?.insertItem(i));
    }
  }

  Future<void> _refresh() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh'),
        content: const Text('Refresh your entries'),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop, child: const Text('Cancel'))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback(itemLoader);
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
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
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
                    padding: EdgeInsets.all(8.0), sliver: EntriesLoadingCard()),
                data: (data) => EntriesList(data: data),
                error: (error) => const SliverFillRemaining(
                      child: Text('error'),
                    ),
                loadMore: (data) => EntriesList(data: data),
                errorLoadMore: ((data, error) => Text('error')),
                end: (data, message) => Text(message)),
          ),
        ],
      ),
    );
  }
}
