import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';
import '../../entity/entity.dart';
import '../dto.dart';

part 'income_dto.g.dart';

@JsonSerializable()
class IncomeDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "added_at")
  final DateTime addedAt;
  @JsonKey(name: "source")
  final List<IncomeSourceDto> sources;
  @JsonKey(name: "desc")
  final String? desc;
  IncomeDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    required this.sources,
    this.desc,
  });

  factory IncomeDto.fromJson(Map<String, dynamic> json) =>
      _$IncomeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeDtoToJson(this);

  IncomeModel toIncomeModel() => IncomeModel(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources.map((e) => e.toIncomeSourceModel()).toList(),
      desc: desc);

  IncomeEntity toEntity() => IncomeEntity(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources.map((e) => e.toEntity()).toList(),
      desc: desc);

  factory IncomeDto.fromEntity(IncomeEntity incomeEntity) => IncomeDto(
        id: incomeEntity.id,
        title: incomeEntity.title,
        desc: incomeEntity.desc,
        amount: incomeEntity.amount,
        addedAt: incomeEntity.addedAt,
        sources: incomeEntity.sources!
            .map((e) => IncomeSourceDto.fromEntity(e))
            .toList(),
      );

  factory IncomeDto.fromIncomeModel(IncomeModel incomeModel) => IncomeDto(
        id: incomeModel.id,
        title: incomeModel.title,
        desc: incomeModel.desc,
        amount: incomeModel.amount,
        addedAt: incomeModel.addedAt,
        sources: incomeModel.sources
            .map((e) => IncomeSourceDto.fromIncomeSourceModel(e))
            .toList(),
      );
}
