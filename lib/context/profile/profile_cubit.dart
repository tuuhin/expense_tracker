import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repo;

  ProfileCubit(this._repo) : super(ProfileState.stateless());

  UserProfileModel? cahcedData() => _repo.cachedProfile();

  // Future<UserProfileModel?> getProfile() => _repo.getProfile();

  Stream<UserProfileModel?> streamProfile() => _repo.streamProfile();

  Future<void> updateProfile(UserProfileModel model) async {
    emit(ProfileState.requesting());
    Resource<UserProfileModel?> update = await _repo.updateProfile(model);

    update.whenOrNull(
      data: (data, message) => emit(ProfileState.successful(
          message: message ?? "Profile Updated successfully")),
      error: (err, errorMessage, data) => emit(
        ProfileState.unSuccessful(err: err, message: errorMessage),
      ),
    );
  }

  Future<void> changePassword(String oldPword, String newPword) async {
    emit(ProfileState.requesting());
    Resource<void> pword = await _repo.changePassword(oldPword, newPword);

    pword.whenOrNull(
      data: (data, message) => emit(ProfileState.successful(
          message: message ?? "changed passord success")),
      error: (err, errorMessage, data) => emit(
        ProfileState.unSuccessful(err: err, message: errorMessage),
      ),
    );
  }
}
