import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/domain/models/entries_information_model.dart';

class EntriesInformationDto {
  String? previousURL;
  String? nextURL;
  int highestCount;
  int overAllCount;
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

  factory EntriesInformationDto.fromJson(Map<String, dynamic> json) {
    List results = json['results'] as List;
    return EntriesInformationDto(
      entries: results.map((e) => EntriesDto.fromJson(e)).toList(),
      highestCount: json['highest_count'],
      overAllCount: json['overall_total'],
      previousURL: json['previous'],
      nextURL: json['next'],
    );
  }
}
