import 'package:hive/hive.dart';

import '../../entity/expense/expense_categories_entity.dart';

class CategoriesStorage {
  static Box<CategoryEntity>? categories;

  static Future<void> init() async {
    categories = await Hive.openBox<CategoryEntity>('expense_categories');
  }

  Future<void> addExpenseCategory(CategoryEntity entity) async =>
      await categories!.put(entity.id, entity);

  Future<void> addExpenseCategories(List<CategoryEntity> enities) async =>
      await categories!
          .putAll(enities.asMap().map((key, e) => MapEntry(e.id, e)));

  Iterable<CategoryEntity> getCategories() =>
      categories!.values.toList().reversed;

  CategoryEntity? getCategoryById(CategoryEntity entity) =>
      categories?.get(entity.id);

  Future<void> updateCategory(CategoryEntity entity) async =>
      await categories?.put(entity.id, entity);

  Future<void> deleteCategory(CategoryEntity entity) async =>
      await categories!.delete(entity.id);

  Future<void> deleteAllCategory() async => await categories!.clear();
}
