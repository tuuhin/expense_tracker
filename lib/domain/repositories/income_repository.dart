import 'package:expense_tracker/domain/models/models.dart';

import '../../utils/resource.dart';

abstract class IncomeRepostiory {
  Future<Resource<List<IncomeSourceModel>>> getSources();
  Future<Resource<IncomeSourceModel?>> createSource(
      CreateIncomeSourceModel source);
  Future<Resource<void>> deleteSource(IncomeSourceModel source);
  List<IncomeSourceModel> cachedSources();

  Future<Resource<List<IncomeModel>>> getIncomes();
  Future<Resource<IncomeModel?>> createIncome(CreateIncomeModel income);
  Future<Resource<void>> deleteIncome(IncomeModel income);
  List<IncomeModel> cachedIncomes();
}
