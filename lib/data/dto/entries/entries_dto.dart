import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entries_dto.g.dart';

@JsonSerializable()
class EntriesDto {
  final int id;
  final String title;
  final String type;
  final String? desc;
  @JsonKey(name: "is_secure")
  final bool? isSecure;

  EntriesDto({
    required this.id,
    required this.title,
    required this.type,
    this.desc,
    this.isSecure,
  });

  factory EntriesDto.fromJson(Map<String, dynamic> json) =>
      _$EntriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesDtoToJson(this);

  factory EntriesDto.fromModel(EntriesModel entry) =>
      EntriesDto(id: entry.id, title: entry.title, type: entry.type);

  EntriesModel toModel() =>
      EntriesModel(id: id, title: title, type: type, desc: desc);
}
