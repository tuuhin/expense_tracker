import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';
part 'notification_dto.g.dart';

@JsonSerializable()
class NotificationDto {
  @JsonKey(name: "count")
  final int count;
  @JsonKey(name: "previous")
  final String? previous;
  @JsonKey(name: "next")
  final String? next;
  @JsonKey(name: "results")
  final Iterable<NotificationDataDto> data;

  NotificationDto({
    required this.count,
    required this.data,
    this.previous,
    this.next,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  NotificationModel toModel() => NotificationModel(
      count: count,
      data: data.map((e) => e.toModel()).toList(),
      previous: previous,
      next: next);
}

@JsonSerializable()
class NotificationDataDto {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "status")
  final NotificationStatus status;

  @JsonKey(name: "at")
  DateTime createdAt;

  @JsonKey(name: "signal")
  final NotificationSignalModel signal;

  NotificationDataDto(
      {required this.id,
      required this.createdAt,
      required this.status,
      required this.title,
      required this.signal});

  factory NotificationDataDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataDtoToJson(this);

  NotificationDataModel toModel() => NotificationDataModel(
      title: title, createdAt: createdAt, type: status, signal: signal);
}

enum NotificationStatus {
  @JsonValue("created")
  created,
  @JsonValue("deleted")
  deleted,
  @JsonValue("updated")
  updated,
  @JsonValue("blank")
  unknown;
}

enum NotificationSignalModel {
  @JsonValue("expense")
  expense,
  @JsonValue("income")
  income,
  @JsonValue("source")
  source,
  @JsonValue("category")
  category,
  @JsonValue("budget")
  budget,
  @JsonValue("goal")
  goal,
  @JsonValue("profile")
  profile,
  @JsonValue("unknown")
  unknown,
}
