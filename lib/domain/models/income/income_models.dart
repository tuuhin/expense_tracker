import 'package:expense_tracker/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_models.freezed.dart';

@freezed
class IncomeModel with _$IncomeModel {
  factory IncomeModel({
    required int id,
    required String title,
    required double amount,
    required DateTime addedAt,
    required List<IncomeSourceModel> sources,
    String? desc,
  }) = _IncomeModel;
}

@freezed
class CreateIncomeModel with _$CreateIncomeModel {
  factory CreateIncomeModel({
    required String title,
    required double amount,
    String? desc,
    required List<int> sourcesId,
  }) = _CreateIncomeModel;
}
