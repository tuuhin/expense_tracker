import 'package:flutter/material.dart';

import '../dto/dto.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class NotificationRepoImpl implements NotificationRepository {
  final NotificationApi api;

  NotificationRepoImpl({required this.api});

  @override
  Future<Resource<NotificationModel>> getMoreNotification(
      {required int offset, int? limit}) async {
    try {
      NotificationDto dto =
          await api.getMoreNotification(offset: offset, limit: limit ?? 5);
      return Resource.data(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "unknown error occured");
    }
  }

  @override
  Future<Resource<NotificationModel>> getNotification() async {
    try {
      NotificationDto dto = await api.getNotification();
      return Resource.data(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "unknown error occured");
    }
  }
}
