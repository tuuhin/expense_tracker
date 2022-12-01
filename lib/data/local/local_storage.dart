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
      ..registerAdapter(ExpenseCategoriesEntityAdapter())
      ..registerAdapter(IncomeEntityAdapter())
      ..registerAdapter(IncomeSourceEntityAdapter())
      ..registerAdapter(BudgetEntityAdapter())
      ..registerAdapter(UserBaseDataEntityAdapter())
      ..registerAdapter(GoalsEntityAdapter());

    await UserProfileData.init();
    await UserThemePreferences.init();
    await ExpenseCategoriesStorage.init();
    await IncomeSourceStorage.init();
    await IncomeStorage.init();
    await ExpenseStorage.init();
    await BudgetStorage.init();
    await UserBaseData.init();
  }

  Future<void> clear() async {
    ExpenseStorage().deleteExpense();
  }
}
