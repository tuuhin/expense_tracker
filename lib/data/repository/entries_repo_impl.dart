import '../../utils/resource.dart';
import '../dto/dto.dart';
import '../remote/entries_api.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/models/models.dart';

class EntriesRepositoryImpl implements EntriesRepository {
  final EntriesApi api;

  EntriesRepositoryImpl({required this.api});
  @override
  Future<Resource<EntriesModel>> getEntries() async {
    EntriesDto dto = await api.getEntries();
    try {
      return Resource.data(data: dto.toModel());
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<EntriesModel>> getMoreEntries(
      {int? offset, int? limit}) async {
    try {
      EntriesDto dto = await api.getMoreEntries(offset: offset, limit: limit);
      return Resource.data(data: dto.toModel());
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }
}
