import 'package:expense_tracker/data/entity/user/user_profile_entity.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProfileData {
  static Box<UserProfileEntity>? _profile;
  static Future init() async {
    _profile = await Hive.openBox<UserProfileEntity>(userDataBox);
  }

  Future<void> addUserProfile(UserProfileEntity user) async =>
      await _profile!.put('profile', user);

  Future<void> updateUserProfile(UserProfileEntity user) async =>
      await _profile!.put('profile', user);

  Future<UserProfileEntity?> getUserProfile() async => _profile!.get('profile');

  Future<void> removeUserProfile() async => await _profile!.delete('profile');
}
