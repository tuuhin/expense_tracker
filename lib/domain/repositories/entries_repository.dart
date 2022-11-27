import '../models/models.dart';

abstract class EntriesRepository {
  Future<EntriesModel> getEntries();

  Future<EntriesModel> getMoreEntries({int? offset, int? limit});
}
