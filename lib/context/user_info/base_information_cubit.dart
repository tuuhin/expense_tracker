import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/dto/user/user_base_overview_dto.dart';
import '../../data/local/storage.dart';
import '../../data/remote/user_base_data.dart';
import '../../domain/models/user/user_base_overview_model.dart';
import '../../domain/repositories/user_base_data_repository.dart';
import '../../main.dart';

part 'base_information_state.dart';

class BaseInformationCubit extends Cubit<BaseInformationState> {
  BaseInformationCubit() : super(BaseInformationLoading());

  final UserBaseDataRepository _repo = UserBaseDataRepoImpl();
  final UserBaseData _baseData = UserBaseData();

  Future<void> getBaseOverView() async {
    UserBaseOverViewModel? cachedData =
        await _baseData.getUserBaseData().then((value) => value?.toModel());

    logger.fine("cached");

    try {
      UserBaseOverViewModel newData = await _repo.getBaseOverView();
      logger.fine('trying for api');
      await _baseData
          .updateBaseData(UserBaseOverviewDto.fromModel(newData).toEntity());

      logger.fine("got updating cache");

      UserBaseOverViewModel? updatedData =
          await _baseData.getUserBaseData().then((value) => value?.toModel());
      emit(BaseInformationLoadSucess(data: updatedData!));
    } on DioError catch (e, stk) {
      logger.shout("failed");
      debugPrintStack(stackTrace: stk);
      emit(BaseInforamtionLoadFailed(
          message: "Error Occured", data: cachedData));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      emit(BaseInforamtionLoadFailed(
          message: "Error Occured", data: cachedData));
    }
  }
}
