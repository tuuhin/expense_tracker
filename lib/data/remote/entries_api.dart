import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/entries/entries_information.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/entries_information_model.dart';
import 'package:expense_tracker/domain/repositories/entries_repository.dart';

class EntriesApi extends ResourceClient implements EntriesRepository {
  @override
  Future<EntriesInfomationModel> getEntries() async {
    Response response = await dio.get('/entries');

    return EntriesInformationDto.fromJson(response.data).toModel();
  }

  @override
  Future<EntriesInfomationModel> getMoreEntries(
      Map<String, dynamic> query) async {
    Response response = await dio.get('/entries', queryParameters: query);
    return EntriesInformationDto.fromJson(response.data).toModel();
  }
}
