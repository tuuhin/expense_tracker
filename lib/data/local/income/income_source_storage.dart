import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class IncomeSourceStorage {
  static late final LazyBox<IncomeSourceEntity>? _sources;

  static Future<void> init() async {
    _sources = await Hive.openLazyBox<IncomeSourceEntity>('income_source');
  }

  Future<void> addSource(IncomeSourceEntity entity) async =>
      await _sources!.put(entity.id, entity);

  Future<void> addSources(List<IncomeSourceEntity> enitites) async {
    await _sources!.putAll(
        enitites.asMap().map((key, enitity) => MapEntry(enitity.id, enitity)));
    await _sources!.flush();
  }

  Future<Iterable<IncomeSourceEntity>> getSources() async =>
      (await Future.wait<IncomeSourceEntity?>(
              _sources!.keys.map((e) => _sources!.get(e))))
          .whereType<IncomeSourceEntity>();

  Future<IncomeSourceEntity?> getEntityById(IncomeSourceEntity entity) =>
      _sources!.get(entity.id);

  Future<void> deleteSource(IncomeSourceEntity entity) async =>
      await _sources!.delete(entity.id);

  Future<void> deleteAll() async => _sources!.clear();
}
