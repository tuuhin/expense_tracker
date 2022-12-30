part of 'base_information_cubit.dart';

@freezed
class BaseInformationState with _$BaseInformationState {
  factory BaseInformationState.loading() = _Load;
  factory BaseInformationState.success({
    required UserBaseOverViewModel data,
    String? message,
  }) = _Data;
  factory BaseInformationState.failed({
    required Object err,
    required String message,
  }) = _Error;
  factory BaseInformationState.errorWithData({
    required Object err,
    required UserBaseOverViewModel data,
    required String message,
  }) = _ErrorWithData;
}
