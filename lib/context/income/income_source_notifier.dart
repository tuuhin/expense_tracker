import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/main.dart';

import '../../domain/models/models.dart';

class IncomeSourceNotifier extends ChangeNotifier {
  final List<IncomeSourceModel> _selectedSources = [];
  List<IncomeSourceModel> get sources => _selectedSources;

  void checkSource(IncomeSourceModel incomeSourceModel) {
    if (_selectedSources.contains(incomeSourceModel)) {
      _selectedSources.remove(incomeSourceModel);
    } else {
      _selectedSources.add(incomeSourceModel);
    }
    notifyListeners();
  }

  void clear() {
    _selectedSources.clear();
    logger.info('clearing');
    notifyListeners();
  }
}
