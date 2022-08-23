part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {}

class UserInfoLoad extends UserInfoState {}

class UserInfoFailed extends UserInfoState {}

class UserInfo extends UserInfoState {
  final UserProfileModel? profile;
  UserInfo({this.profile});
}
