import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class IncomeSourceStorage {
  static Box<IncomeSourceEntity>? incomeSource;

  static Future<void> init() async {
    incomeSource = await Hive.openBox<IncomeSourceEntity>('income_source');
  }

  Future<void> addSource(IncomeSourceEntity entity) async =>
      await incomeSource!.put(entity.id, entity);

  Future<void> addSources(List<IncomeSourceEntity> enitites) async {
    await incomeSource!.putAll(
        enitites.asMap().map((key, enitity) => MapEntry(enitity.id, enitity)));
    await incomeSource!.flush();
  }

  Iterable<IncomeSourceEntity> getSources() => incomeSource!.values;

  IncomeSourceEntity? getEntityById(IncomeSourceEntity entity) =>
      incomeSource!.get(entity.id);

  Future<void> deleteSource(IncomeSourceEntity entity) async =>
      await incomeSource!.delete(entity.id);

  Future<void> deleteAll() async =>
      incomeSource!.keys.map((e) async => await incomeSource!.delete(e));
}
