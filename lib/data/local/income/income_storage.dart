import 'package:hive/hive.dart';

import '../../entity/entity.dart';

class IncomeStorage {
  static Box<IncomeEntity>? income;

  static Future<void> init() async {
    income = await Hive.openBox<IncomeEntity>('income');
  }

  Future<void> addIncome(IncomeEntity entity) async =>
      await income!.put(entity.id, entity);

  Future<void> addIncomes(List<IncomeEntity> enitites) async =>
      await income!.putAll(
          enitites.asMap().map((key, entity) => MapEntry(entity.id, entity)));

  Iterable<IncomeEntity> getIncomes() => income!.values.toList();

  IncomeEntity? getEntityById(IncomeEntity entity) => income!.get(entity.id);

  Future<void> deleteIncome(IncomeEntity entity) async {
    await income!.delete(entity.id);
  }

  Future<void> deleteAll() async =>
      income!.keys.map((e) async => income!.delete(e));
}
