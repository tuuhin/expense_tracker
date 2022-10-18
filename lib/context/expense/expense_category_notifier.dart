import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../main.dart';

class ExpenseCategoryNotifier extends ChangeNotifier {
  final List<ExpenseCategoriesModel> _selectedCategories = [];
  List<ExpenseCategoriesModel> get sources => _selectedCategories;

  void checkCategory(ExpenseCategoriesModel categoriesModel) {
    if (!categoryInList(categoriesModel)) {
      _selectedCategories.add(categoriesModel);
    } else {
      _selectedCategories.remove(categoriesModel);
    }
    notifyListeners();
  }

  bool categoryInList(ExpenseCategoriesModel categoriesModel) =>
      _selectedCategories.contains(categoriesModel);

  void clear() {
    _selectedCategories.clear();
    logger.info('clearing expense category tags');
    notifyListeners();
  }
}
