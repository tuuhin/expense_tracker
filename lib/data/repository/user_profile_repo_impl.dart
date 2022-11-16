import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/models/auth/user_profile_model.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../main.dart';
import '../../utils/resource.dart';
import '../dto/dto.dart';
import '../entity/user/user_profile_entity.dart';
import '../local/storage.dart';
import '../remote/clients/auth_client.dart';

class UserProfileRepositoryImpl extends AuthClient
    implements UserProfileRepository {
  final UserProfileData _profile = UserProfileData();

  @override
  Future<UserProfileModel?> getProfile() async {
    UserProfileEntity? userProfile = await _profile.getUserProfile();
    if (userProfile == null) {
      try {
        Response response = await dio.get('/profile');
        UserProfileModel userProfileModel =
            UserProfileDto.fromJson(response.data).toModel();
        await _profile.updateUserProfile(
            UserProfileDto.fromModel(userProfileModel).toEntity());
        UserProfileEntity? updatedProfile = await _profile.getUserProfile();
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
  Future<Resource<UserProfileModel>> updateProfile(
      UserProfileModel model) async {
    Map<String, dynamic> data = <String, dynamic>{
      ...UserProfileDto.fromModel(model).toJson(),
      'photoURL': model.photoURL != null
          ? await MultipartFile.fromFile(model.photoURL!,
              filename: model.photoURL)
          : null
    };
    if (model.email == null) data.addAll({'email': ''});
    if (model.phoneNumber == null) data.addAll({'phoneNumber': ''});

    logger.fine(data);
    try {
      Response response = await dio.put('/update-profile',
          data: FormData.fromMap(data, ListFormat.multi));
      logger.fine(response.data);
      UserProfileModel profile =
          await setProfile(UserProfileDto.fromJson(response.data).toModel());

      return Resource.data(
          data: profile, message: "Profile Changed Sucessfully");
    } on DioError catch (dio) {
      return Resource.error(
          err: dio, errorMessage: dio.response?.statusMessage ?? "DIO ERROR");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      logger.severe(e.toString());
      return Resource.error(err: e, errorMessage: "ERROR OCCURED");
    }
  }

  @override
  Future<Resource<void>> changePassword(
      String oldPword, String newPword) async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      logger.fine("req");
      await dio.post('/change-password', data: <String, String>{
        'old_password': oldPword,
        'new_password': newPword
      });
      return Resource.data(
          data: null, message: "Succcessfully changed youkr password");
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
  Future<UserProfileModel> setProfile(UserProfileModel userProfileModel) async {
    await _profile.updateUserProfile(
        UserProfileDto.fromModel(userProfileModel).toEntity());
    UserProfileEntity? updatedProfile = await _profile.getUserProfile();
    return UserProfileDto.fromEntity(updatedProfile!).toModel();
  }
}
