import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/data/local/storage.dart';
import 'package:expense_tracker/data/remote/clients/auth_client.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl extends AuthClient
    implements UserProfileRepository {
  final UserProfileData _profile = UserProfileData();

  @override
  Future<UserProfileModel?> getProfile() async {
    UserProfileEntity? userProfile = await _profile.getUserProfile();

    if (userProfile == null) {
      Response response = await dio.get('/profile');
      UserProfileModel userProfileModel =
          UserProfileDto.fromJson(response.data).toModel();
      await _profile.updateUserProfile(
          UserProfileDto.fromModel(userProfileModel).toEntity());
      return userProfileModel;
    } else {
      return UserProfileDto.fromEntity(userProfile).toModel();
    }
  }

  @override
  Future<UserProfileModel> updateProfile(
      UserProfileModel userProfileModel) async {
    Response response = await dio.put('/profile',
        data: UserProfileDto.fromModel(userProfileModel).toJson());

    UserProfileModel model = UserProfileDto.fromJson(response.data).toModel();
    await _profile
        .updateUserProfile(UserProfileDto.fromModel(model).toEntity());
    return model;
  }
}
