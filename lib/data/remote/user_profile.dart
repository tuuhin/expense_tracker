import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/models/auth/user_profile_model.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../main.dart';
import '../../utils/resource.dart';
import '../dto/user/user_profile_dto.dart';
import '../entity/user/user_profile_entity.dart';
import '../local/storage.dart';
import './clients/auth_client.dart';

class UserProfileRepositoryImpl extends AuthClient
    implements UserProfileRepository {
  final UserProfileData _profile = UserProfileData();

  @override
  Future<Resource<UserProfileModel>> getProfile() async {
    UserProfileEntity? userProfile = await _profile.getUserProfile();

    if (userProfile == null) {
      try {
        Response response = await dio.get('/profile');
        UserProfileModel userProfileModel =
            UserProfileDto.fromJson(response.data).toModel();
        await _profile.updateUserProfile(
            UserProfileDto.fromModel(userProfileModel).toEntity());
        UserProfileEntity? updatedProfile = await _profile.getUserProfile();
        return Resource.data(
            data: UserProfileDto.fromEntity(updatedProfile!).toModel());
      } on DioError catch (err) {
        return Resource.error(
            err: err,
            errorMessage:
                err.response?.statusMessage ?? "DIO RELATED ERROR OCCURED");
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        logger.shout('Error Occured');

        return Resource.error(err: e, errorMessage: "ERROR OCCURED");
      }
    }
    return Resource.data(
        data: UserProfileDto.fromEntity(userProfile).toModel());
  }

  @override
  Future<Resource<UserProfileModel>> updateProfile(
      UserProfileModel userProfileModel) async {
    try {
      Response response = await dio.put(
        '/profile',
        data: FormData.fromMap(
          UserProfileDto.fromModel(userProfileModel).toJson(),
          ListFormat.multi,
        ),
      );
      UserProfileDto.fromJson(response.data).toModel();
      await _profile.updateUserProfile(
          UserProfileDto.fromModel(userProfileModel).toEntity());
      UserProfileEntity? updatedProfile = await _profile.getUserProfile();
      return Resource.data(
          data: UserProfileDto.fromEntity(updatedProfile!).toModel());
    } on DioError catch (dio) {
      logger.shout(dio.error);
      return Resource.error(
          err: dio, errorMessage: dio.response?.statusMessage ?? "DIO ERROR");
    } catch (e) {
      logger.severe(e.toString());
      return Resource.error(err: e, errorMessage: "ERROR OCCURED");
    }
  }

  @override
  Future changePassword(String oldPword, String newPword) async {}

  @override
  Future<void> setProfile(UserProfileModel userProfileModel) async {
    await _profile.updateUserProfile(
        UserProfileDto.fromModel(userProfileModel).toEntity());
  }
}
