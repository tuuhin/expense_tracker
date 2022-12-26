import 'package:json_annotation/json_annotation.dart';

import '../../entity/entity.dart';
import '../../../domain/models/models.dart';

part 'base_overview_dto.g.dart';

@JsonSerializable()
class BaseOverviewDto {
  @JsonKey(name: 'total_income')
  final double totalIncome;
  @JsonKey(name: 'monthly_income')
  final double monthlyIncome;
  @JsonKey(name: 'total_expense')
  final double totalExpense;
  @JsonKey(name: 'monthly_expense')
  final double monthlyExpense;

  BaseOverviewDto({
    required this.totalIncome,
    required this.monthlyExpense,
    required this.totalExpense,
    required this.monthlyIncome,
  });

  factory BaseOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$BaseOverviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BaseOverviewDtoToJson(this);

  UserBaseOverViewModel toModel() => UserBaseOverViewModel(
        totalIncome: totalIncome,
        monthlyIncome: monthlyIncome,
        totalExpense: totalExpense,
        monthlyExpense: monthlyExpense,
      );

  UserBaseDataEntity toEntity() => UserBaseDataEntity(
        monthlyExpense: monthlyExpense,
        totalExpense: totalExpense,
        monthlyIncome: monthlyIncome,
        totalIncome: totalIncome,
      );

  factory BaseOverviewDto.fromModel(UserBaseOverViewModel model) =>
      BaseOverviewDto(
        totalIncome: model.totalIncome,
        monthlyExpense: model.monthlyExpense,
        totalExpense: model.totalExpense,
        monthlyIncome: model.monthlyIncome,
      );

  factory BaseOverviewDto.fromEntity(UserBaseDataEntity entity) =>
      BaseOverviewDto(
        totalIncome: entity.totalIncome,
        monthlyExpense: entity.monthlyExpense,
        totalExpense: entity.totalExpense,
        monthlyIncome: entity.monthlyIncome,
      );
}
