import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class EntriesRepository {
  Future<Resource<EntriesModel>> getEntries();

  Future<Resource<EntriesModel>> getMoreEntries({int? offset, int? limit});
}
