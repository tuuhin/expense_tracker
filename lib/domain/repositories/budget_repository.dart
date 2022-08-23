import 'package:expense_tracker/domain/models/budget/budget_model.dart';

abstract class BudgetRepository {
  Future createBudget();
  Future deleteBudget();
  Future<List<BudgetModel>> getBudget();
}
