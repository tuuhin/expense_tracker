class UserProfileModel {
  int? phoneNumber;
  String? firstName;
  String? lastName;
  String? photoURL;
  String? email;
  String? createdAt;
  String? updatedAt;

  UserProfileModel({
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  // set setPhoneNumber(int? phoneNumber) => this.phoneNumber = phoneNumber;
  // set setFirstName(String? firstName) => this.firstName = firstName;
  // set setLastName(String? lastName) => this.lastName = lastName;
  // set setPhotoURL(String? photoURL) => this.photoURL = photoURL;

  @override
  String toString() => '$firstName $lastName';
}
