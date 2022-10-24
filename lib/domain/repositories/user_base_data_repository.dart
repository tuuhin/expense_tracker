import '../models/user/user_base_overview_model.dart';

abstract class UserBaseDataRepository {
  Future<UserBaseOverViewModel> getBaseOverView();
}
