import 'package:json_annotation/json_annotation.dart';

part 'income_source_model.g.dart';

@JsonSerializable()
class IncomeSourceModel {
  final int id;
  final String title;
  final String? desc;
  final bool? isSecure;
  IncomeSourceModel(
      {required this.id, required this.title, this.desc, this.isSecure});

  factory IncomeSourceModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeSourceModelToJson(this);
}
