import 'package:freezed_annotation/freezed_annotation.dart';

part 'goals_model.freezed.dart';

@freezed
class GoalsModel with _$GoalsModel {
  factory GoalsModel({
    required int id,
    required String title,
    required double collected,
    required DateTime createdAt,
    required DateTime updatedAt,
    required double price,
    required bool accomplished,
    String? desc,
    String? imageUrl,
  }) = _GoalsModel;
}
