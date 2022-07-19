import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/domain/models/expense/expense_categories_model.dart';
import 'package:hive/hive.dart';

import '../../entity/expense/expense_categories_entity.dart';

class ExpenseCategoriesStorage {
  static Box<ExpenseCategoriesEntity>? expenseCategories;

  static Future<void> init() async {
    expenseCategories =
        await Hive.openBox<ExpenseCategoriesEntity>('expense_categories');
  }

  Future<void> addExpenseCategory(
          ExpenseCategoriesModel expenseCategoriesModel) async =>
      await expenseCategories!.add(
        ExpenseCategoryDto.fromExpenseCategoryModel(expenseCategoriesModel)
            .toEntity(),
      );

  Future<void> addExpenseCategories(
          List<ExpenseCategoriesModel> expenseCategoriesModels) async =>
      await expenseCategories!.addAll(
        expenseCategoriesModels.map(
          (ExpenseCategoriesModel model) =>
              ExpenseCategoryDto.fromExpenseCategoryModel(model).toEntity(),
        ),
      );

  List<ExpenseCategoriesModel> getExpenseCategories() =>
      expenseCategories!.values
          .map((e) =>
              ExpenseCategoryDto.fromExpenseEntity(e).toExpenseCategoryModel())
          .toList();

  int _getIndexOfEnitity(ExpenseCategoriesModel expenseCategoriesModel) =>
      getExpenseCategories().indexOf(expenseCategoriesModel);

  Future<void> deleteExpenseCategory(
          ExpenseCategoriesModel expenseCategoriesModel) async =>
      await expenseCategories!
          .deleteAt(_getIndexOfEnitity(expenseCategoriesModel));

  Future<void> deleteExpenseCategories() async =>
      await expenseCategories!.clear();
}
