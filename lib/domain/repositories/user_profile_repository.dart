import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class UserProfileRepository {
  Future<Resource<UserProfileModel>> updateProfile(
      UserProfileModel userProfileModel);

  Future<Resource<UserProfileModel>> getProfile();

  Future<void> setProfile(UserProfileModel userProfileModel);

  Future changePassword(String oldPword, String newPword);
}
