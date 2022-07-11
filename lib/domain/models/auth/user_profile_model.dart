import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 01)
class UserProfileModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? phoneNumber;

  @HiveField(2)
  String? firstName;

  @HiveField(3)
  String? lastName;

  @HiveField(4)
  String? photoURL;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? updatedAt;

  UserProfileModel({
    this.id,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  set setPhoneNumber(int? phoneNumber) => this.phoneNumber = phoneNumber;
  set setFirstName(String? firstName) => this.firstName = firstName;
  set setLastName(String? lastName) => this.lastName = lastName;
  set setPhotoURL(String? photoURL) => this.photoURL = photoURL;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'],
        phoneNumber: json['phoneNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        photoURL: json['photoURL'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'photoURL': photoURL,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  String toString() => '$id. $firstName $lastName';
}
