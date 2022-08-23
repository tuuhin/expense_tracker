import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/domain/repositories/user_profile_repository.dart';
import 'package:flutter/material.dart';

import '../../data/remote/user_data_api.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoLoad());

  final UserProfileRepository _userProfileRepository =
      UserProfileRepositoryImpl();

  Future<UserProfileModel> getProfile() async =>
      await _userProfileRepository.getProfile();
}
