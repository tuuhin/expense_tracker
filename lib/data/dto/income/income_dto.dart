import 'package:json_annotation/json_annotation.dart';

import '../dto.dart';
import '../../entity/entity.dart';
import '../../../domain/models/models.dart';

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

  IncomeModel toModel() => IncomeModel(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources.map((e) => e.toModel()).toList(),
      desc: desc);

  IncomeEntity toEntity() => IncomeEntity(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources.map((e) => e.toEntity()).toList(),
      desc: desc);

  factory IncomeDto.fromEntity(IncomeEntity entity) => IncomeDto(
        id: entity.id,
        title: entity.title,
        desc: entity.desc,
        amount: entity.amount,
        addedAt: entity.addedAt,
        sources:
            entity.sources.map((e) => IncomeSourceDto.fromEntity(e)).toList(),
      );

  factory IncomeDto.fromModel(IncomeModel model) => IncomeDto(
        id: model.id,
        title: model.title,
        desc: model.desc,
        amount: model.amount,
        addedAt: model.addedAt,
        sources:
            model.sources.map((e) => IncomeSourceDto.fromModel(e)).toList(),
      );
}
