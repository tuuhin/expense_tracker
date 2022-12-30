import '../../utils/resource.dart';
import '../models/models.dart';

abstract class ProfileRepository {
  Future<Resource<UserProfileModel?>> updateProfile(UserProfileModel model);

  Future<UserProfileModel?> getProfile();

  UserProfileModel? cachedProfile();

  Stream<UserProfileModel?> streamProfile();

  Future<void> setProfile(UserProfileModel userProfileModel);

  Future<Resource<void>> changePassword(String oldPword, String newPword);

  Future<void> clearCache();
}
