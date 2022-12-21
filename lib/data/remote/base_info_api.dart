import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/resource_client.dart';

class BaseInfoApi extends ResourceClient {
  Future<UserBaseOverviewDto> getBaseOverView() async {
    Response response = await dio.get('/info');
    return UserBaseOverviewDto.fromJSON(response.data);
  }
}
