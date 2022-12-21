import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class UserBaseData {
  static Box<UserBaseDataEntity>? _baseData;
  static Future init() async {
    _baseData = await Hive.openBox<UserBaseDataEntity>('base-data');
  }

  Future<void> updateBaseData(UserBaseDataEntity data) async =>
      await _baseData!.put('base-data', data);

  Future<UserBaseDataEntity?> getUserBaseData() async =>
      _baseData?.get('base-data');
}
