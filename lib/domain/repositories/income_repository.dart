import 'package:expense_tracker/domain/models/models.dart';

abstract class IncomeRepostiory {
  Future<IncomeModel?> createIncome(String title, double amount,
      {String? desc, List<IncomeSourceModel>? sources});

  Future<IncomeSourceModel?> createSource(String title,
      {String? desc, bool? isSecure});

  Future deleteSource(IncomeSourceModel incomeSourceModel);

  Future deleteIncome(IncomeModel incomeModel);

  Future<List<IncomeSourceModel>?> getSources();

  Future<List<IncomeModel>?> getIcomes();
}
