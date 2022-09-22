import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/remote/user_data_api.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../main.dart';
import '../../utils/resource.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoLoad());

  final UserProfileRepository _userProfileRepository =
      UserProfileRepositoryImpl();

  Future setProfile() async {}

  Future<UserProfileModel> getProfile() async =>
      await _userProfileRepository.getProfile();

  Future<Resource> changePassword(String oldPword, String newPword) async {
    try {
      await _userProfileRepository.changePassword(oldPword, newPword);
      return ResourceSucess();
    } catch (e) {
      logger.severe(e.toString());
      return ResourceFailed(message: e.toString());
    }
  }
}
