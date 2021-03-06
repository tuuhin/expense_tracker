import 'package:expense_tracker/data/entity/income/income_source_entity.dart';
import 'package:expense_tracker/domain/models/models.dart';

class IncomeSourceDto {
  final int id;
  final String title;
  final String? desc;
  final bool? isSecure;
  IncomeSourceDto({
    required this.id,
    required this.title,
    this.desc,
    this.isSecure,
  });

  factory IncomeSourceDto.fromJson(Map<String, dynamic> json) =>
      IncomeSourceDto(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        isSecure: json['is_secure'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'is_secure': isSecure,
      };

  IncomeSourceEntity toEntity() =>
      IncomeSourceEntity(id: id, title: title, desc: desc, isSecure: isSecure);

  factory IncomeSourceDto.fromEntity(IncomeSourceEntity incomeSourceEntity) =>
      IncomeSourceDto(
        id: incomeSourceEntity.id,
        title: incomeSourceEntity.title,
        desc: incomeSourceEntity.desc,
        isSecure: incomeSourceEntity.isSecure,
      );

  IncomeSourceModel toIncomeSourceModel() =>
      IncomeSourceModel(id: id, title: title, desc: desc, isSecure: isSecure);

  factory IncomeSourceDto.fromIncomeSourceModel(
          IncomeSourceModel incomeSourceModel) =>
      IncomeSourceDto(
        id: incomeSourceModel.id,
        title: incomeSourceModel.title,
        desc: incomeSourceModel.desc,
        isSecure: incomeSourceModel.isSecure,
      );
}
