import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'remote.dart';

class IncomeApi extends ResourceClient {
  Future<IncomeDto> createIncome(CreateIncomeDto dto) async {
    Response response = await dio.post('/income', data: dto.toJson());
    return IncomeDto.fromJson(response.data);
  }

  Future<IncomeDto> updateIncome(IncomeDto dto) async {
    Response response = await dio.put('/income/${dto.id}', data: dto.toJson());
    return IncomeDto.fromJson(response.data);
  }

  Future<IncomeSourceDto> createSource(CreateSourceDto dto) async {
    Response response = await dio.post('/sources', data: dto.toJson());
    return IncomeSourceDto.fromJson(response.data);
  }

  Future<Iterable<IncomeDto>> getIcomes() async {
    Response response = await dio.get('/income');
    return (response.data as List).map((json) => IncomeDto.fromJson(json));
  }

  Future<Iterable<IncomeSourceDto>> getSources() async {
    Response response = await dio.get('/sources');
    return (response.data as List)
        .map((json) => IncomeSourceDto.fromJson(json));
  }

  Future deleteIncome(IncomeDto dto) async =>
      await dio.delete('/income/${dto.id}');

  Future deleteSource(IncomeSourceDto dto) async =>
      await dio.delete('/sources/${dto.id}');
}
