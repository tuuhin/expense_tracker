import 'package:freezed_annotation/freezed_annotation.dart';
part 'entries_model.freezed.dart';
part 'entries_model.g.dart';

@Freezed()
class EntriesModel with _$EntriesModel {
  const factory EntriesModel(
      {required int id,
      required String title,
      required String type,
      String? desc,
      bool? isSecure}) = _EntriesModel;

  factory EntriesModel.fromJson(Map<String, dynamic> json) =>
      _$EntriesModelFromJson(json);
}
