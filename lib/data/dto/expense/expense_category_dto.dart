import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';
import '../../entity/entity.dart';

part 'expense_category_dto.g.dart';

@JsonSerializable()
class ExpenseCategoryDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "desc")
  final String? desc;
  ExpenseCategoryDto({required this.id, required this.title, this.desc});

  factory ExpenseCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryDtoFromJson(json);

  factory ExpenseCategoryDto.fromEntity(CategoryEntity entity) =>
      ExpenseCategoryDto(id: entity.id, title: entity.title, desc: entity.desc);

  factory ExpenseCategoryDto.fromModel(ExpenseCategoriesModel model) =>
      ExpenseCategoryDto(id: model.id, title: model.title, desc: model.desc);

  Map<String, dynamic> toJson() => _$ExpenseCategoryDtoToJson(this);

  CategoryEntity toEntity() => CategoryEntity(id: id, title: title, desc: desc);

  ExpenseCategoriesModel toModel() =>
      ExpenseCategoriesModel(id: id, title: title, desc: desc);
}
