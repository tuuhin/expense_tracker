import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/models.dart';

part 'create_goal_dto.g.dart';

@JsonSerializable()
class CreateGoalDto {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "desc")
  String? desc;
  @JsonKey(name: "collected")
  double collected;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "image")
  String? imageUrl;

  CreateGoalDto({
    required this.title,
    required this.price,
    required this.collected,
    this.desc,
    this.imageUrl,
  });

  factory CreateGoalDto.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalDtoFromJson(json);

  factory CreateGoalDto.fromModel(CreateGoalModel model) => CreateGoalDto(
      title: model.title,
      price: model.price,
      collected: model.collected,
      desc: model.desc,
      imageUrl: model.imageUrl);

  Map<String, dynamic> toJson() => _$CreateGoalDtoToJson(this);
}
