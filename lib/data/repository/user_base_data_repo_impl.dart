import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dto/dto.dart';
import '../entity/entity.dart';
import '../local/storage.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class UserBaseDataRepoImpl implements UserBaseDataRepository {
  final BaseInfoApi api;
  final UserBaseData dao;

  UserBaseDataRepoImpl({required this.dao, required this.api});

  @override
  Future<Resource<UserBaseOverViewModel?>> getBaseOverView() async {
    UserBaseDataEntity? cache = dao.getData();

    try {
      BaseOverviewDto dto = await api.getBaseOverView();

      await dao.updateData(dto.toEntity());
      UserBaseDataEntity? entity = dao.getData();
      if (entity == null) return Resource.data(data: null);
      return Resource.data(data: BaseOverviewDto.fromEntity(entity).toModel());
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: "DIO ERROR",
        data:
            cache != null ? BaseOverviewDto.fromEntity(cache).toModel() : null,
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(
        err: e,
        errorMessage: "unknown error",
        data:
            cache != null ? BaseOverviewDto.fromEntity(cache).toModel() : null,
      );
    }
  }

  @override
  Future<void> clearCache() => dao.delete();
}
