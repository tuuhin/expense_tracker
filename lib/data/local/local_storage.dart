import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/enums/theme_enum.dart';
import '../entity/entity.dart';
import './storage.dart';

class LocalStorage {
  Future init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(UserProfileEntityAdapter())
      ..registerAdapter(ThemeEnumAdapter())
      ..registerAdapter(ExpenseEntityAdapter())
      ..registerAdapter(CategoryEntityAdapter())
      ..registerAdapter(IncomeEntityAdapter())
      ..registerAdapter(IncomeSourceEntityAdapter())
      ..registerAdapter(BudgetEntityAdapter())
      ..registerAdapter(UserBaseDataEntityAdapter())
      ..registerAdapter(GoalsEntityAdapter());

    await UserProfileDao.init();
    await UserThemePreferences.init();
    await CategoriesStorage.init();
    await IncomeSourceStorage.init();
    await IncomeStorage.init();
    await ExpenseStorage.init();
    await BudgetStorage.init();
    await UserBaseData.init();
    await GoalsDao.init();
  }
}
