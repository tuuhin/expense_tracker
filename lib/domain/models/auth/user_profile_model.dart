import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    int? phoneNumber,
    String? firstName,
    String? lastName,
    String? photoURL,
    String? email,
    String? createdAt,
    String? updatedAt,
  }) = _UserProfileModel;

  // set setPhoneNumber(int? phoneNumber) => this.phoneNumber = phoneNumber;
  // set setFirstName(String? firstName) => this.firstName = firstName;
  // set setLastName(String? lastName) => this.lastName = lastName;
  // set setPhotoURL(String? photoURL) => this.photoURL = photoURL;

}
