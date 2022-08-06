import 'package:expense_tracker/domain/models/entries_model.dart';

class EntriesDto {
  final int id;
  final String title;
  final String type;
  final String? desc;
  final bool? isSecure;

  EntriesDto({
    required this.id,
    required this.title,
    required this.type,
    this.desc,
    this.isSecure,
  });

  factory EntriesDto.fromJson(Map<String, dynamic> json) => EntriesDto(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      desc: json['desc'],
      isSecure: json['isSecure']);

  factory EntriesDto.fromModel(EntriesModel entry) =>
      EntriesDto(id: entry.id, title: entry.title, type: entry.type);

  EntriesModel toModel() =>
      EntriesModel(id: id, title: title, type: type, desc: desc);
}
