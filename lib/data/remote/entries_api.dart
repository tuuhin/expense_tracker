import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:expense_tracker/domain/repositories/entries_repository.dart';

class EntriesApi extends ResourceClient implements EntriesRepository {
  @override
  Future<List<EntriesModel>> getEntries() async {
    Response response = await dio.get('/entries');
    List results = response.data['results'];
    return results
        .map<EntriesModel>((e) => EntriesDto.fromJson(e).toModel())
        .toList();
  }

  @override
  Future<List<EntriesModel>> getMoreEntries(Map<String, dynamic> query) async {
    Response response = await dio.get('/entries', queryParameters: query);
    List results = response.data['results'];
    return results
        .map<EntriesModel>((e) => EntriesDto.fromJson(e).toModel())
        .toList();
  }
}
