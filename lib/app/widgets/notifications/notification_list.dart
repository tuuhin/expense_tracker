import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../widgets.dart';

class NotificationList extends StatefulWidget {
  final List<NotificationDataModel> data;
  const NotificationList({Key? key, required this.data}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  void _addItems(Duration _) async {
    final GlobalKey<SliverAnimatedListState> key =
        context.read<NotificationBloc>().key;

    for (int i = 0; i < widget.data.length; i++) {
      await Future.delayed(
        const Duration(milliseconds: 100),
        () => key.currentState?.insertItem(i),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(_addItems);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverAnimatedList(
        key: context.read<NotificationBloc>().key,
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: NotificationCard(
            data: widget.data[index],
          ),
        ),
      ),
    );
  }
}
