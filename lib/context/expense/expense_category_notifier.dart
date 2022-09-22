import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../main.dart';

class ExpenseCategoryNotifier extends ChangeNotifier {
  final List<ExpenseCategoriesModel> _selectedCategories = [];
  List<ExpenseCategoriesModel> get sources => _selectedCategories;

  void checkCategory(ExpenseCategoriesModel categoriesModel) {
    if (!categoryInList(categoriesModel)) {
      _selectedCategories.add(categoriesModel);
      logger.info('adding category');
    } else {
      _selectedCategories
          .removeWhere((element) => element.id == categoriesModel.id);
      logger.info('removing category ');
    }
    notifyListeners();
  }

  bool categoryInList(ExpenseCategoriesModel categoriesModel) =>
      _selectedCategories
          .where((element) => element.id == categoriesModel.id)
          .isNotEmpty;

  void clear() {
    _selectedCategories.clear();
    logger.info('clearing expense category tags');
    notifyListeners();
  }
}
