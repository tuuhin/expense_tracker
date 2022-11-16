import 'package:json_annotation/json_annotation.dart';

part 'details_dto.g.dart';

@JsonSerializable()
class ErrorDetialsDto {
  @JsonKey(name: 'details')
  String? details;

  ErrorDetialsDto({this.details});

  factory ErrorDetialsDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetialsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetialsDtoToJson(this);
}
