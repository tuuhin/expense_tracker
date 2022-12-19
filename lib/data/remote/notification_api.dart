import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/plans_client.dart';

class NotificationApi extends PlansClient {
  Future<NotificationDto> getNotification() async {
    Response response = await dio.get('/notification');

    return NotificationDto.fromJson(response.data);
  }

  Future<NotificationDto> getMoreNotification({int? offset, int? limit}) async {
    Response response = await dio.get(
      '/notification',
      queryParameters: <String, int?>{'offset': offset, 'limit': limit},
    );

    return NotificationDto.fromJson(response.data);
  }
}
