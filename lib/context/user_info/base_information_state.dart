part of 'base_information_cubit.dart';

@immutable
abstract class BaseInformationState {}

class BaseInformationLoading extends BaseInformationState {}

class BaseInformationLoadSucess extends BaseInformationState {
  final UserBaseOverViewModel data;
  final String? message;
  BaseInformationLoadSucess({required this.data, this.message});
}

class BaseInforamtionLoadFailed extends BaseInformationState {
  final UserBaseOverViewModel? data;
  final String message;
  BaseInforamtionLoadFailed({this.data, required this.message});
}
