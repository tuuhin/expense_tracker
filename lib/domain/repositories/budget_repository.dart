import '../models/models.dart';

abstract class BudgetRepository {
  Future createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc});

  Future<List<BudgetModel>> getBudget();

  Future deleteBudget(BudgetModel budget);
}
