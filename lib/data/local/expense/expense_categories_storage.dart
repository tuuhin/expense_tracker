import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/domain/models/models.dart';
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
          .map((ExpenseCategoriesEntity e) =>
              ExpenseCategoryDto.fromExpenseEntity(e).toExpenseCategoryModel())
          .toList();

  Future<void> deleteExpenseCategory(
      ExpenseCategoriesModel expenseCategoriesModel) async {
    int index = getExpenseCategories()
        .indexWhere((element) => element.id == expenseCategoriesModel.id);
    await expenseCategories!.deleteAt(index);
  }

  Future<void> deleteExpenseCategories() async =>
      await expenseCategories!.clear();
}
