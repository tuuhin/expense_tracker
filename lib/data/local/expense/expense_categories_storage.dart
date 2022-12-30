import 'package:hive/hive.dart';

import '../../entity/expense/expense_categories_entity.dart';

class CategoriesStorage {
  static late final LazyBox<CategoryEntity>? _categories;

  static Future<void> init() async {
    _categories = await Hive.openLazyBox<CategoryEntity>('expense_categories');
  }

  Future<void> addCategory(CategoryEntity entity) async =>
      await _categories!.put(entity.id, entity);

  Future<void> addCategories(List<CategoryEntity> enities) async =>
      await _categories!
          .putAll(enities.asMap().map((key, e) => MapEntry(e.id, e)));

  Future<Iterable<CategoryEntity>> getCategories() async =>
      (await Future.wait<CategoryEntity?>(
              _categories!.keys.map((e) => _categories!.get(e))))
          .whereType<CategoryEntity>();

  Future<CategoryEntity?> getCategoryById(CategoryEntity entity) async =>
      await _categories?.get(entity.id);

  Future<void> deleteCategory(CategoryEntity entity) async =>
      await _categories!.delete(entity.id);

  Future<void> deleteAll() async => _categories!.clear();
}
