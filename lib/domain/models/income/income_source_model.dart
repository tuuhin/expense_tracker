import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_source_model.freezed.dart';

@freezed
class IncomeSourceModel with _$IncomeSourceModel {
  factory IncomeSourceModel({
    required int id,
    required String title,
    String? desc,
    required bool? isSecure,
  }) = _IncomeSourceModel;
}

@freezed
class CreateIncomeSourceModel with _$CreateIncomeSourceModel {
  factory CreateIncomeSourceModel({
    required String title,
    required bool isSecure,
    String? desc,
  }) = _CreateIncomeSourceModel;
}
