import 'package:expense_tracker/utils/resource.dart';

import '../models/models.dart';

abstract class ExpenseRespository {
  Future<Resource<List<ExpenseCategoriesModel>>> getCategories();
  Future<Resource<ExpenseCategoriesModel?>> createCategory(
      CreateCategoryModel category);
  Future<Resource<void>> deleteCategory(ExpenseCategoriesModel category);
  List<ExpenseCategoriesModel> cachedCategories();

  Future<Resource<List<ExpenseModel>>> getExpense();
  Future<Resource<ExpenseModel?>> createExpense(CreateExpenseModel expense);
  Future<Resource<void>> deleteExpense(ExpenseModel expense);
  List<ExpenseModel> cachedExpenses();
}
