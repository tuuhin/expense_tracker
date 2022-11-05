import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/entries_information_model.dart';
import '../dto.dart';

part 'entries_information.g.dart';

@JsonSerializable()
class EntriesInformationDto {
  @JsonKey(name: "previous")
  String? previousURL;
  @JsonKey(name: "next")
  String? nextURL;
  @JsonKey(name: "highest_count")
  int highestCount;
  @JsonKey(name: "overall_total")
  int overAllCount;
  @JsonKey(name: "results")
  List<EntriesDto> entries;

  EntriesInformationDto({
    required this.entries,
    this.previousURL,
    this.nextURL,
    required this.highestCount,
    required this.overAllCount,
  });

  EntriesInfomationModel toModel() => EntriesInfomationModel(
        highestCount: highestCount,
        overAllCount: overAllCount,
        nextURL: nextURL,
        previousURL: previousURL,
        entries: entries.map((e) => e.toModel()).toList(),
      );

  factory EntriesInformationDto.fromJson(Map<String, dynamic> json) =>
      _$EntriesInformationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesInformationDtoToJson(this);
}
