import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../widgets/widgets.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  late ScrollController _scrollController;

  void _scrollListener() async {
    double delta = MediaQuery.of(context).size.height * .2;
    if (_scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <=
        delta) {
      context.read<NotificationBloc>().fetchMore();
    }
  }

  Future<void> _refresh() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Refresh Notifications',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Refresh your notifications',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () => context
                    .read<NotificationBloc>()
                    .refresh()
                    .then(Navigator.of(context).pop),
                child: const Text('Refresh'))
          ],
        ),
      );

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
                'Notifications',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                    "What you create, update ,delete are are looked upon. View the app use history"),
              ),
            ),
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) => state.when(
                loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator())),
                data: (data) => NotificationList(data: data),
                error: (err, message) =>
                    SliverToBoxAdapter(child: Text(message)),
                loadmore: (data) => NotificationList(data: data),
                errorLoadMore: (err, message, data) =>
                    NotificationList(data: data),
                end: (message, data) => NotificationList(data: data),
                noData: (message) => SliverToBoxAdapter(child: Text(message)),
              ),
            ),
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) => state.maybeWhen(
                  orElse: () =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  loadmore: (data) => const PaginatorLoadMore(),
                  errorLoadMore: (error, message, data) =>
                      PaginatorLoadMoreFailed(message: message),
                  end: (message, data) => PaginatorEnd(message: message)),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20))
          ],
        ),
      ),
    );
  }
}
