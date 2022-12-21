import 'package:dio/dio.dart';

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
    UserBaseDataEntity? cache = await dao.getUserBaseData();

    try {
      UserBaseOverviewDto dto = await api.getBaseOverView();
      dao.updateBaseData(dto.toEntity());
      UserBaseDataEntity? entity = await dao.getUserBaseData();
      if (entity == null) return Resource.data(data: null);
      return Resource.data(
          data: UserBaseOverviewDto.fromEntity(entity).toModel());
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: "DIO ERROR",
        data: cache != null
            ? UserBaseOverviewDto.fromEntity(cache).toModel()
            : null,
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "unknown error",
        data: cache != null
            ? UserBaseOverviewDto.fromEntity(cache).toModel()
            : null,
      );
    }
  }
}
