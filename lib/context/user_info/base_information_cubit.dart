import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'base_information_state.dart';
part 'base_information_cubit.freezed.dart';

class BaseInformationCubit extends Cubit<BaseInformationState> {
  BaseInformationCubit(this._repo) : super(BaseInformationState.loading());

  final UserBaseDataRepository _repo;

  Future<void> init() async {
    emit(BaseInformationState.loading());
    Resource<UserBaseOverViewModel?> resource = await _repo.getBaseOverView();
    resource.whenOrNull(
      data: (data, message) => (data != null)
          ? emit(BaseInformationState.success(data: data))
          : emit(BaseInformationState.success(
              data: UserBaseOverViewModel.noData())),
      error: (err, errorMessage, data) => data != null
          ? emit(BaseInformationState.errorWithData(
              err: err, data: data, message: errorMessage))
          : emit(BaseInformationState.failed(err: err, message: errorMessage)),
    );
  }

  Future<void> clearCache() async => _repo.clearCache();

  Future<void> refresh() async => init();
}
