import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../dto/dto.dart';
import '../entity/entity.dart';
import '../remote/remote.dart';
import '../local/storage.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.api, required this.profile});

  @override
  final UserProfileDao profile;

  @override
  final UserDataApi api;

  @override
  Stream<UserProfileModel?> streamProfile() =>
      profile.streamData().asyncMap((event) {
        if (event == null) return null;
        return UserProfileDto.fromEntity(event).toModel();
      });

  @override
  UserProfileModel? cachedProfile() {
    UserProfileEntity? cache = profile.getProfile();
    logger.fine(cache);
    if (cache == null) return null;
    return UserProfileDto.fromEntity(cache).toModel();
  }

  @override
  Future<UserProfileModel?> getProfile() async {
    UserProfileEntity? userProfile = profile.getProfile();
    if (userProfile == null) {
      try {
        UserProfileDto dto = await api.getUserProfile();
        UserProfileModel userProfile = dto.toModel();
        await profile
            .updateProfile(UserProfileDto.fromModel(userProfile).toEntity());
        UserProfileEntity? updatedProfile = profile.getProfile();
        return UserProfileDto.fromEntity(updatedProfile!).toModel();
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        logger.shout('Error Occured');

        return null;
      }
    }
    return UserProfileDto.fromEntity(userProfile).toModel();
  }

  @override
  Future<Resource<UserProfileModel?>> updateProfile(
      UserProfileModel model) async {
    try {
      UserProfileDto dto =
          await api.updateProfile(UserProfileDto.fromModel(model));
      UserProfileModel? profile = await setProfile(dto.toModel());

      return Resource.data(
          data: profile, message: "Profile Changed Sucessfully");
    } on DioError catch (dio) {
      return Resource.error(
          err: dio, errorMessage: dio.response?.statusMessage ?? "DIO ERROR");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "ERROR OCCURED");
    }
  }

  @override
  Future<Resource<void>> changePassword(
      String oldPword, String newPword) async {
    try {
      logger.fine("oke");
      await api.changePassword(
          ChangePasswordDto(oldPassword: oldPword, newPassword: newPword));
      return Resource.data(
          data: null, message: "Succcessfully changed your password");
    } on DioError catch (e) {
      return Resource.error(
        err: e,
        errorMessage:
            ErrorDetialsDto.fromJson((e.response!.data as Map<String, dynamic>))
                    .details ??
                'DIO ERROR',
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: 'Unknown Error');
    }
  }

  @override
  Future<UserProfileModel?> setProfile(UserProfileModel model) async {
    await profile.updateProfile(UserProfileDto.fromModel(model).toEntity());
    UserProfileEntity? updatedProfile = profile.getProfile();
    logger.fine(updatedProfile?.photoURL);
    if (updatedProfile == null) return null;
    return UserProfileDto.fromEntity(updatedProfile).toModel();
  }
}
