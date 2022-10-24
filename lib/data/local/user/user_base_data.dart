import 'package:expense_tracker/data/entity/user/user_base_data_entity.dart';
import 'package:hive/hive.dart';

class UserBaseData {
  static Box<UserBaseDataEntity>? _baseData;
  static Future init() async {
    _baseData = await Hive.openBox<UserBaseDataEntity>('base-data');
  }

  Future<void> updateBaseData(UserBaseDataEntity data) async =>
      await _baseData?.put('base-data', data);

  Future<UserBaseDataEntity?> getUserBaseData() async =>
      _baseData?.get('base-data');
}
