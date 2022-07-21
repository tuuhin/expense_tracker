import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/main.dart';

import '../../domain/models/models.dart';

class IncomeSourceNotifier extends ChangeNotifier {
  final List<IncomeSourceModel> _selectedSources = [];
  List<IncomeSourceModel> get sources => _selectedSources;
  void checkSource(IncomeSourceModel incomeSourceModel) {
    if (!sourceInList(incomeSourceModel)) {
      _selectedSources.add(incomeSourceModel);
      logger.info('adding');
    } else {
      _selectedSources
          .removeWhere((element) => element.id == incomeSourceModel.id);
      logger.info('removing');
    }
    notifyListeners();
  }

  bool sourceInList(IncomeSourceModel incomeSourceModel) => _selectedSources
      .where((element) => element.id == incomeSourceModel.id)
      .isNotEmpty;

  void clear() {
    _selectedSources.clear();
    logger.info('clearing');
    notifyListeners();
  }
}
