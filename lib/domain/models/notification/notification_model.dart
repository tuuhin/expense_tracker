import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/notification/notification_dto.dart';

part 'notification_model.freezed.dart';

@freezed
class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    required int count,
    String? previous,
    String? next,
    required List<NotificationDataModel> data,
  }) = _NotificationModel;
}

@freezed
class NotificationDataModel with _$NotificationDataModel {
  factory NotificationDataModel({
    required String title,
    required DateTime createdAt,
    required NotificationStatus type,
    required NotificationSignalModel signal,
  }) = _NotificationDataModel;
}
