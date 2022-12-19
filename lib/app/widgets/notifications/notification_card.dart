import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/date_formaters.dart';
import 'notification_color_mapper.dart';

class NotificationCard extends StatelessWidget {
  final NotificationDataModel data;
  const NotificationCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = NotificationColorMapper.getColor(data.type);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: ListTile(
          trailing: Text(
            data.type.name.toUpperCase(),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          title: Text(
            '${data.signal.name.toUpperCase()}: ${data.title}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          subtitle: Text(
            toDate(data.createdAt),
            style: TextStyle(color: color.withOpacity(0.75)),
          ),
        ),
      ),
    );
  }
}
