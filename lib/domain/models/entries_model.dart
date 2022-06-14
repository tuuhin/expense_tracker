import 'package:json_annotation/json_annotation.dart';

part 'entries_model.g.dart';

@JsonSerializable()
class EntriesModel {
  final int id;
  final String title;
  final String type;
  final String? desc;
  final bool? isSecure;
  EntriesModel({
    required this.id,
    required this.title,
    required this.type,
    this.desc,
    this.isSecure,
  });

  factory EntriesModel.fromJson(Map<String, dynamic> json) =>
      _$EntriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesModelToJson(this);
}
