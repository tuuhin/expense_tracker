import 'package:flutter/material.dart';

import '../../../data/dto/dto.dart';

class NotificationColorMapper {
  static final Map<NotificationStatus, Color> _colorMap = {
    NotificationStatus.created: Colors.green,
    NotificationStatus.deleted: Colors.red,
    NotificationStatus.updated: Colors.blue,
    NotificationStatus.unknown: Colors.yellow
  };

  static Color getColor(NotificationStatus status) =>
      _colorMap[status] ?? Colors.grey;
}
