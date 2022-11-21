import 'package:expense_tracker/domain/models/models.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NotificationRepository {
  Future<NotificationModel> getNotification();

  Future<NotificationModel> getMoreNotification({int? offset, int? limit});
}
