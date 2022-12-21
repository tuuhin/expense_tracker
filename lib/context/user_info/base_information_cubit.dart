import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../utils/resource.dart';

part 'base_information_state.dart';
part 'base_information_cubit.freezed.dart';

class BaseInformationCubit extends Cubit<BaseInformationState> {
  BaseInformationCubit(this._repo) : super(BaseInformationState.loading());

  final UserBaseDataRepository _repo;

  Future<void> getBaseOverView() async {
    Resource<UserBaseOverViewModel?> resource = await _repo.getBaseOverView();
    resource.whenOrNull(
      data: (data, message) {
        if (data != null) {
          emit(BaseInformationState.success(data: data));
        }
      },
      error: (err, errorMessage, data) {},
    );
  }
}
