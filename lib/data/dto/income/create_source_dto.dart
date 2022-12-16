import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_source_dto.g.dart';

@JsonSerializable()
class CreateSourceDto {
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "desc")
  final String? desc;
  @JsonKey(name: "is_secure")
  final bool isSecure;

  CreateSourceDto({required this.title, required this.isSecure, this.desc});

  factory CreateSourceDto.fromJson(Map<String, dynamic> json) =>
      _$CreateSourceDtoFromJson(json);

  factory CreateSourceDto.fromModel(CreateIncomeSourceModel model) =>
      CreateSourceDto(
          title: model.title, desc: model.desc, isSecure: model.isSecure);

  Map<String, dynamic> toJson() => _$CreateSourceDtoToJson(this);

  CreateIncomeSourceModel toModel() =>
      CreateIncomeSourceModel(title: title, desc: desc, isSecure: isSecure);
}
