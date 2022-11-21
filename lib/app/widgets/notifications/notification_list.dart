import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationDataModel> data;
  const NotificationList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
        key: context.read<NotificationBloc>().key,
        itemBuilder: (context, index, animation) {
          final NotificationDataModel model = data[index];
          final Animation<Offset> offset = Tween<Offset>(
                  begin: const Offset(-1, 0), end: Offset.zero)
              .animate(
                  CurvedAnimation(parent: animation, curve: Curves.bounceIn));
          return SlideTransition(
            position: offset,
            child: Card(
              child: ListTile(
                title: Text(model.title),
                subtitle: Text(toDate(model.createdAt)),
              ),
            ),
          );
        },
      );
}
