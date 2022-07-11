import 'package:expense_tracker/domain/models/models.dart';

abstract class IncomeRepostiory {
  Future<bool> createIncome(String title, double amount,
      {String? desc, List<IncomeSourceModel>? source});

  Future<bool> createSource(String title, {String? desc, bool? isSecure});

  Future<bool> deleteSource(int id);

  Future<List<IncomeSourceModel>?> getSources();

  Future<IncomeModel?> getIcomes();

  Future<bool> deleteIncome(int id);
}
