import 'package:flutter/cupertino.dart';

import '../dto/dto.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class EntriesRepositoryImpl implements EntriesRepository {
  final EntriesApi api;

  EntriesRepositoryImpl({required this.api});
  @override
  Future<Resource<EntriesModel>> getEntries() async {
    try {
      EntriesDto dto = await api.getEntries();
      return Resource.data(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<EntriesModel>> getMoreEntries(
      {int? offset, int? limit}) async {
    try {
      EntriesDto dto = await api.getMoreEntries(offset: offset, limit: limit);
      return Resource.data(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }
}
