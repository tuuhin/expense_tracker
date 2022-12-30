import 'package:expense_tracker/domain/models/models.dart';

import '../../utils/resource.dart';

abstract class IncomeRepostiory {
  Future<Resource<List<IncomeSourceModel>>> getSources();
  Future<Resource<IncomeSourceModel?>> createSource(
      CreateIncomeSourceModel source);
  Future<Resource<void>> deleteSource(IncomeSourceModel source);
  Future<List<IncomeSourceModel>> cachedSources();

  Future<void> clearcachedSources();

  Future<Resource<List<IncomeModel>>> getIncomes();
  Future<Resource<IncomeModel?>> createIncome(CreateIncomeModel income);
  Future<Resource<void>> deleteIncome(IncomeModel income);
  Future<Resource<IncomeModel?>> updateIncome(UpdateIncomeModel income);

  Future<void> clearcachedIncomes();
}
