import 'package:expense_tracker/domain/models/models.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel> updateProfile(UserProfileModel userProfileModel);

  Future<UserProfileModel> getProfile();
}
