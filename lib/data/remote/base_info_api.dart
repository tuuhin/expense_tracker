import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/resource_client.dart';

class BaseInfoApi extends ResourceClient {
  Future<BaseOverviewDto> getBaseOverView() async {
    Response response = await dio.get('/info');
    return BaseOverviewDto.fromJson(response.data);
  }
}
