import 'package:hive_flutter/hive_flutter.dart';

import '../../entity/entity.dart';

class UserProfileDao {
  static late final Box<UserProfileEntity>? _profile;
  static Future<void> init() async {
    _profile = await Hive.openBox<UserProfileEntity>('user-profile');
  }

  Future<void> setProfile(UserProfileEntity user) async {
    await _profile!.put('profile', user);
    await _profile!.flush();
  }

  Future<void> updateProfile(UserProfileEntity user) async {
    await _profile!.put('profile', user);
    await _profile!.flush();
  }

  Stream<UserProfileEntity?> streamData() async* {
    yield* Stream.value(_profile?.get('profile'));
    yield* _profile!.watch(key: 'profile').map((box) => box.value);
  }

  UserProfileEntity? getProfile() => _profile!.get('profile');

  Future<void> removeProfile() async => await _profile!.delete('profile');

  Future<void> clear() => _profile!.clear();
}
