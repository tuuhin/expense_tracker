import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class NotificationsData extends StatelessWidget {
  const NotificationsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) => state.when(
        loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator())),
        data: (data) => NotificationList(data: data),
        error: (err) => SliverToBoxAdapter(child: Text(err)),
        loadmore: (data) => NotificationList(data: data),
        errorLoadMore: (data, message) => NotificationList(data: data),
        end: (data, message) => NotificationList(data: data),
      ),
    );
  }
}
