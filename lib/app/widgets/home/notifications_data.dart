import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class NotificationsData extends StatefulWidget {
  const NotificationsData({Key? key}) : super(key: key);

  @override
  State<NotificationsData> createState() => _NotificationsDataState();
}

class _NotificationsDataState extends State<NotificationsData> {
  late ScrollController _controller;

  void fetchMore() {
    double delta = MediaQuery.of(context).size.height * .2;
    if (_controller.position.maxScrollExtent - _controller.position.pixels <=
        delta) {
      context.read<NotificationBloc>().fetchMore();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(fetchMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .5,
      child: CustomScrollView(controller: _controller, slivers: [
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) => state.when(
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            data: (data) => NotificationList(data: data),
            error: (err) => SliverToBoxAdapter(child: Text(err)),
            loadmore: (data) => NotificationList(data: data),
            errorLoadMore: (data, message) => NotificationList(data: data),
            end: (data, message) => NotificationList(data: data),
          ),
        ),
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) => state.maybeWhen(
              orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              loadmore: (data) => SliverToBoxAdapter(child: Text('more')),
              end: (data, message) => SliverToBoxAdapter(child: Text(message))),
        ),
      ]),
    );
  }
}
