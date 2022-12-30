import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class UserBaseData {
  static late final Box<UserBaseDataEntity>? _baseData;
  static Future init() async {
    _baseData = await Hive.openBox<UserBaseDataEntity>('base-data');
  }

  Future<void> updateData(UserBaseDataEntity data) async =>
      await _baseData!.put('base-data', data);

  UserBaseDataEntity? getData() => _baseData?.get('base-data');

  Future<void> delete() async => await _baseData?.delete('base-data');
}
