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

  EntriesModel toModel() => EntriesModel(id: id, title: title, type: type);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'type': type,
        'isSecure': isSecure
      };
}
