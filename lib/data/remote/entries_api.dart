import 'package:dio/dio.dart';
import '../remote/remote.dart';
import '../dto/dto.dart';

class EntriesApi extends ResourceClient {
  Future<EntriesDto> getEntries() async {
    Response response = await dio.get('/entries');
    return EntriesDto.fromJson(response.data);
  }

  Future<EntriesDto> getMoreEntries({int? offset, int? limit}) async {
    Response response = await dio.get('/entries',
        queryParameters: <String, int?>{'offset': offset, 'limit': limit});
    return EntriesDto.fromJson(response.data);
  }
}
