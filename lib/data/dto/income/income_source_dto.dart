import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';
import '../../entity/income/income_source_entity.dart';

part 'income_source_dto.g.dart';

@JsonSerializable()
class IncomeSourceDto {
  final int id;
  final String title;
  final String? desc;
  @JsonKey(name: 'is_secure')
  final bool isSecure;

  IncomeSourceDto({
    required this.id,
    required this.title,
    this.desc,
    required this.isSecure,
  });

  factory IncomeSourceDto.fromJson(Map<String, dynamic> json) =>
      _$IncomeSourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeSourceDtoToJson(this);

  IncomeSourceEntity toEntity() =>
      IncomeSourceEntity(id: id, title: title, desc: desc, isSecure: isSecure);

  factory IncomeSourceDto.fromEntity(IncomeSourceEntity entity) =>
      IncomeSourceDto(
        id: entity.id,
        title: entity.title,
        desc: entity.desc,
        isSecure: entity.isSecure ?? false,
      );

  IncomeSourceModel toModel() =>
      IncomeSourceModel(id: id, title: title, desc: desc, isSecure: isSecure);

  factory IncomeSourceDto.fromModel(IncomeSourceModel model) => IncomeSourceDto(
        id: model.id,
        title: model.title,
        desc: model.desc,
        isSecure: model.isSecure ?? false,
      );
}
