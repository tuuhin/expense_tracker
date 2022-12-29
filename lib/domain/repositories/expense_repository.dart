import '../models/models.dart';
import '../../utils/resource.dart';

abstract class ExpenseRespository {
  Future<Resource<List<ExpenseCategoriesModel>>> getCategories();
  Future<Resource<ExpenseCategoriesModel?>> createCategory(
      CreateCategoryModel category);
  Future<Resource<void>> deleteCategory(ExpenseCategoriesModel category);
  Future<List<ExpenseCategoriesModel>> cachedCategories();

  Future<Resource<List<ExpenseModel>>> getExpense();
  Future<Resource<ExpenseModel?>> createExpense(CreateExpenseModel expense);
  Future<Resource<void>> deleteExpense(ExpenseModel expense);
  Future<Resource<ExpenseModel?>> updateExpense(UpdateExpenseModel expense);
}
