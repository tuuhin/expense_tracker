import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'entries_dto.g.dart';

@JsonSerializable()
class EntriesDto {
  @JsonKey(name: "previous")
  String? previousURL;
  @JsonKey(name: "next")
  String? nextURL;
  @JsonKey(name: "highest_count")
  int highestCount;
  @JsonKey(name: "overall_total")
  int overAllCount;
  @JsonKey(name: "results")
  List<EntriesDataDto> entries;

  EntriesDto({
    required this.entries,
    this.previousURL,
    this.nextURL,
    required this.highestCount,
    required this.overAllCount,
  });

  EntriesModel toModel() => EntriesModel(
        highestCount: highestCount,
        overAllCount: overAllCount,
        nextURL: nextURL,
        previousURL: previousURL,
        entries: entries.map((e) => e.toModel()).toList(),
      );

  factory EntriesDto.fromJson(Map<String, dynamic> json) =>
      _$EntriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesDtoToJson(this);
}

@JsonSerializable()
class EntriesDataDto {
  final int id;
  final String title;
  final String type;
  final String? desc;
  @JsonKey(name: "is_secure")
  final bool? isSecure;

  EntriesDataDto({
    required this.id,
    required this.title,
    required this.type,
    this.desc,
    this.isSecure,
  });

  factory EntriesDataDto.fromJson(Map<String, dynamic> json) =>
      _$EntriesDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesDataDtoToJson(this);

  EntriesDataModel toModel() =>
      EntriesDataModel(title: title, type: type, desc: desc);
}
