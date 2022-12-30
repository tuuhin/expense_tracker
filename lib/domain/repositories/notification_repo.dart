import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/utils/resource.dart';

abstract class NotificationRepository {
  Future<Resource<NotificationModel>> getNotification();

  Future<Resource<NotificationModel>> getMoreNotification(
      {required int offset, int? limit});
}
