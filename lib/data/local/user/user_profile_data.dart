import 'package:hive_flutter/hive_flutter.dart';

import '../../entity/entity.dart';

class UserProfileData {
  static late final Box<UserProfileEntity>? _profile;
  static Future init() async {
    _profile = await Hive.openBox<UserProfileEntity>('user-profile');
  }

  Future<void> addUserProfile(UserProfileEntity user) async =>
      await _profile!.put('profile', user);

  Future<void> updateUserProfile(UserProfileEntity user) async =>
      await _profile!.put('profile', user);

  Future<UserProfileEntity?> getUserProfile() async => _profile?.get('profile');

  Future<void> removeUserProfile() async => await _profile?.delete('profile');
}
