import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class NotificationsDataLoadMore extends StatelessWidget {
  const NotificationsDataLoadMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) => state.maybeWhen(
          orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
          loadmore: (data) => SliverToBoxAdapter(child: Text('more')),
          end: (data, message) => SliverToBoxAdapter(child: Text(message))),
    );
  }
}
