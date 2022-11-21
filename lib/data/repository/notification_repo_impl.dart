import 'package:dio/dio.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/notification_repo.dart';
import '../dto/dto.dart';
import '../remote/clients/plans_client.dart';

class NotificationRepoImpl extends PlansClient
    implements NotificationRepository {
  @override
  Future<NotificationModel> getNotification() async {
    Response response = await dio.get('/notification');

    return NotificationDto.fromJson(response.data).toModel();
  }

  @override
  Future<NotificationModel> getMoreNotification(
      {int? offset, int? limit}) async {
    Response response = await dio.get('/notification',
        queryParameters: <String, int?>{'offset': offset, 'limit': limit});

    return NotificationDto.fromJson(response.data).toModel();
  }
}
