import '../../utils/resource.dart';
import '../models/models.dart';

abstract class BudgetRepository {
  Future<Resource<BudgetModel?>> createBudget(CreateBudgetModel budget);

  Future<Resource<BudgetModel?>> updateBudget(BudgetModel budget);

  Future<Resource<List<BudgetModel>>> getBudget();

  Future<Resource<void>> deleteBudget(BudgetModel budget);
}
