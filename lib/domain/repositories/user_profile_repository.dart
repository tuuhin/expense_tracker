import 'package:expense_tracker/data/local/storage.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class ProfileRepository {
  final UserProfileDao profile;

  final UserDataApi api;

  ProfileRepository(this.profile, this.api);

  Future<Resource<UserProfileModel?>> updateProfile(UserProfileModel model);

  Future<UserProfileModel?> getProfile();

  UserProfileModel? cachedProfile();

  Stream<UserProfileModel?> streamProfile();

  Future<void> setProfile(UserProfileModel userProfileModel);

  Future<Resource<void>> changePassword(String oldPword, String newPword);
}
