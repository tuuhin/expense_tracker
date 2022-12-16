import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_income_dto.g.dart';

@JsonSerializable()
class CreateIncomeDto {
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "source")
  final List<int> sourcesId;

  CreateIncomeDto({
    required this.title,
    required this.amount,
    this.desc,
    required this.sourcesId,
  });

  factory CreateIncomeDto.fromJson(Map<String, dynamic> json) =>
      _$CreateIncomeDtoFromJson(json);

  factory CreateIncomeDto.fromModel(CreateIncomeModel model) => CreateIncomeDto(
      title: model.title, amount: model.amount, sourcesId: model.sourcesId);

  Map<String, dynamic> toJson() => _$CreateIncomeDtoToJson(this);

  CreateIncomeModel toModel() => CreateIncomeModel(
      amount: amount, sourcesId: sourcesId, title: title, desc: desc);
}
