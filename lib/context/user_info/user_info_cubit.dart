import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/remote/user_data_api.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/user_profile_repository.dart';

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
      return Resource.data(data: null, message: "Password changed ");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "SOME PROBLEM OCCURED");
    }
  }
}
