import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_category_dto.g.dart';

@JsonSerializable()
class CreateCategoryDto {
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "desc")
  final String? desc;
  CreateCategoryDto({required this.title, this.desc});

  factory CreateCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryDtoToJson(this);

  factory CreateCategoryDto.fromModel(CreateCategoryModel model) =>
      CreateCategoryDto(title: model.title, desc: model.desc);

  CreateCategoryModel toModel() =>
      CreateCategoryModel(title: title, desc: desc);
}
