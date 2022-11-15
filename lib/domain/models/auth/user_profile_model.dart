import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    int? phoneNumber,
    required String firstName,
    String? lastName,
    String? photoURL,
    String? email,
    DateTime? createdAt,
    required DateTime updatedAt,
  }) = _UserProfileModel;
}
