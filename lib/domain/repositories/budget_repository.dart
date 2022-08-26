import 'package:expense_tracker/domain/models/budget/budget_model.dart';

abstract class BudgetRepository {
  Future createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc});

  Future<List<BudgetModel>> getBudget();
}
