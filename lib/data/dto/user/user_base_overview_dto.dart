import 'package:expense_tracker/data/entity/entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/user/user_base_overview_model.dart';

part 'user_base_overview_dto.g.dart';

@JsonSerializable()
class UserBaseOverviewDto {
  @JsonKey(name: 'total_income')
  final double totalIncome;
  @JsonKey(name: 'monthly_income')
  final double monthlyIncome;
  @JsonKey(name: 'total_expense')
  final double totalExpense;
  @JsonKey(name: 'monthly_expense')
  final double monthlyExpense;

  UserBaseOverviewDto({
    required this.totalIncome,
    required this.monthlyExpense,
    required this.totalExpense,
    required this.monthlyIncome,
  });

  factory UserBaseOverviewDto.fromJSON(Map<String, dynamic> json) =>
      _$UserBaseOverviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserBaseOverviewDtoToJson(this);

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
      totalIncome: totalIncome);

  factory UserBaseOverviewDto.fromModel(UserBaseOverViewModel model) =>
      UserBaseOverviewDto(
          totalIncome: model.totalIncome,
          monthlyExpense: model.monthlyExpense,
          totalExpense: model.totalExpense,
          monthlyIncome: model.monthlyIncome);

  factory UserBaseOverviewDto.fromEntity(UserBaseDataEntity entity) =>
      UserBaseOverviewDto(
        totalIncome: entity.totalExpense,
        monthlyExpense: entity.monthlyExpense,
        totalExpense: entity.totalExpense,
        monthlyIncome: entity.monthlyIncome,
      );
}
