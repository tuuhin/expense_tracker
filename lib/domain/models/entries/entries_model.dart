import 'package:freezed_annotation/freezed_annotation.dart';

part 'entries_model.freezed.dart';

@freezed
class EntriesModel with _$EntriesModel {
  factory EntriesModel({
    String? previousURL,
    String? nextURL,
    required int highestCount,
    required int overAllCount,
    required List<EntriesDataModel> entries,
  }) = _EntriesModel;
}

@freezed
class EntriesDataModel with _$EntriesDataModel {
  factory EntriesDataModel({
    required String title,
    required String type,
    String? desc,
    @Default(false) bool isSecure,
  }) = _EntriesDataModel;
}
