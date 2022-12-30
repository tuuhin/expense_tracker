import 'package:expense_tracker/utils/resource.dart';

import '../models/user/user_base_overview_model.dart';

abstract class UserBaseDataRepository {
  Future<Resource<UserBaseOverViewModel?>> getBaseOverView();

  Future<void> clearCache();
}
