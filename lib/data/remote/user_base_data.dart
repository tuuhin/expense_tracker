import 'package:dio/dio.dart';

import '../../domain/models/user/user_base_overview_model.dart';
import '../../domain/repositories/user_base_data_repository.dart';

import '../dto/user/user_base_overview_dto.dart';
import './clients/resource_client.dart';

class UserBaseDataRepoImpl extends ResourceClient
    implements UserBaseDataRepository {
  @override
  Future<UserBaseOverViewModel> getBaseOverView() async {
    Response response = await dio.get('/info');
    return UserBaseOverviewDto.fromJSON(response.data).toModel();
  }
}
