import 'package:freezed_annotation/freezed_annotation.dart';
part 'income_source_model.freezed.dart';
part 'income_source_model.g.dart';

@Freezed()
class IncomeSourceModel with _$IncomeSourceModel {
  const factory IncomeSourceModel(
      {required int id,
      required String title,
      String? desc,
      bool? isSecure}) = _IncomeSourceModel;

  factory IncomeSourceModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeSourceModelFromJson(json);
}
