import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/main.dart';

import '../../domain/models/models.dart';

class IncomeSourceNotifier extends ChangeNotifier {
  final List<IncomeSourceModel> _selectedSources = [];
  List<IncomeSourceModel> get sources => _selectedSources;

  void checkSource(IncomeSourceModel incomeSourceModel) {
    if (!sourceInList(incomeSourceModel)) {
      _selectedSources.add(incomeSourceModel);
    } else {
      _selectedSources.remove(incomeSourceModel);
    }
    notifyListeners();
  }

  bool sourceInList(IncomeSourceModel incomeSourceModel) =>
      _selectedSources.contains(incomeSourceModel);

  void clear() {
    _selectedSources.clear();
    logger.info('clearing');
    notifyListeners();
  }
}
