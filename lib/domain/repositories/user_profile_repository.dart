import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class UserProfileRepository {
  Future<Resource<UserProfileModel>> updateProfile(
      UserProfileModel userProfileModel);

  Future<UserProfileModel?> getProfile();

  Future<UserProfileModel> setProfile(UserProfileModel userProfileModel);

  Future<Resource<void>> changePassword(String oldPword, String newPword);
}
