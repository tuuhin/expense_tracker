import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'update_income_dto.g.dart';

@JsonSerializable()
class UpdateIncomeDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "source")
  final List<int> sourcesId;

  UpdateIncomeDto({
    required this.id,
    required this.title,
    required this.amount,
    this.desc,
    required this.sourcesId,
  });

  factory UpdateIncomeDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateIncomeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIncomeDtoToJson(this);

  factory UpdateIncomeDto.fromModel(UpdateIncomeModel model) => UpdateIncomeDto(
      id: model.id,
      title: model.title,
      amount: model.amount,
      desc: model.desc,
      sourcesId: model.sources.map((e) => e.id).toList());
}
