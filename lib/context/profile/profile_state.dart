part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState.stateless() = _Stateless;
  factory ProfileState.requesting() = _Requesting;

  factory ProfileState.successful({required String message}) = _UpdateSucessful;
  factory ProfileState.unSuccessful(
      {required Object err, required String message}) = _UpdateFailed;
}
