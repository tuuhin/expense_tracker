import 'package:dio/dio.dart';

import '../dto/dto.dart';
import '../remote/remote.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/models/entries/entries_model.dart';

class EntriesRepositoryImpl extends ResourceClient
    implements EntriesRepository {
  @override
  Future<EntriesModel> getEntries() async {
    Response response = await dio.get('/entries');

    return EntriesDto.fromJson(response.data).toModel();
  }

  @override
  Future<EntriesModel> getMoreEntries({int? offset, int? limit}) async {
    Response response = await dio.get('/entries',
        queryParameters: <String, int?>{'offset': offset, 'limit': limit});

    return EntriesDto.fromJson(response.data).toModel();
  }
}
