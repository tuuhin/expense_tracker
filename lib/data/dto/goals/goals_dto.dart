import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/goals/goals_model.dart';
import '../../entity/goals/goals_entity.dart';

part 'goals_dto.g.dart';

@JsonSerializable()
class GoalsDto {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "desc")
  String? desc;
  @JsonKey(name: "collected")
  double collected;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  double price;
  @JsonKey(name: "image")
  String? imageUrl;
  @JsonKey(name: 'is_accomplished')
  bool accomplished;

  GoalsDto({
    required this.id,
    required this.title,
    required this.collected,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.accomplished,
    this.desc,
    this.imageUrl,
  });

  factory GoalsDto.fromJson(Map<String, dynamic> json) =>
      _$GoalsDtoFromJson(json);

  factory GoalsDto.fromModel(GoalsModel model) => GoalsDto(
        id: model.id,
        title: model.title,
        collected: model.collected,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        price: model.price,
        accomplished: model.accomplished,
        imageUrl: model.imageUrl,
      );

  factory GoalsDto.fromEntity(GoalsEntity entity) => GoalsDto(
      id: entity.id,
      title: entity.title,
      collected: entity.collected,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      price: entity.price,
      accomplished: entity.accomplished,
      imageUrl: null);

  Map<String, dynamic> toJson() => _$GoalsDtoToJson(this);

  GoalsModel toModel() => GoalsModel(
        id: id,
        title: title,
        collected: collected,
        createdAt: createdAt,
        updatedAt: updatedAt,
        price: price,
        accomplished: accomplished,
        imageUrl: imageUrl,
      );

  GoalsEntity toEntity() => GoalsEntity(
        id: id,
        title: title,
        collected: collected,
        createdAt: createdAt,
        updatedAt: updatedAt,
        price: price,
        accomplished: accomplished,
      );
}
