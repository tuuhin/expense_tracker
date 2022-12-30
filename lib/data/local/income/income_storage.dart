import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class IncomeStorage {
  static late final LazyBox<IncomeEntity>? income;

  static Future<void> init() async {
    income = await Hive.openLazyBox<IncomeEntity>('income');
  }

  Future<void> addIncome(IncomeEntity entity) async =>
      await income!.put(entity.id, entity);

  Future<void> addIncomes(List<IncomeEntity> enitites) async =>
      await income!.putAll(
          enitites.asMap().map((key, entity) => MapEntry(entity.id, entity)));

  Future<Iterable<IncomeEntity>> getIncomes() async =>
      (await Future.wait<IncomeEntity?>(
              income!.keys.map((e) => income!.get(e))))
          .whereType<IncomeEntity>();

  Future<void> updateIncome(IncomeEntity entity) async =>
      await income!.put(entity.id, entity);

  Future<IncomeEntity?> getEntityById(IncomeEntity entity) async =>
      await income!.get(entity.id);

  Future<void> deleteIncome(IncomeEntity entity) async =>
      await income!.delete(entity.id);

  Future<void> deleteAll() async => await income!.clear();
}
