import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/data/entity/income/income_entity.dart';
import 'package:expense_tracker/data/entity/income/income_source_entity.dart';
import 'package:expense_tracker/data/local/income/income_source_storage.dart';
import 'package:expense_tracker/data/local/income/income_storage.dart';

import 'package:expense_tracker/data/local/storage.dart';
import 'package:expense_tracker/domain/enums/enums.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static Future init() async {
    Hive
      ..registerAdapter(UserProfileEntityAdapter())
      ..registerAdapter(ThemeEnumAdapter())
      ..registerAdapter(ExpenseEntityAdapter())
      ..registerAdapter(ExpenseCategoriesEntityAdapter())
      ..registerAdapter(IncomeEntityAdapter())
      ..registerAdapter(IncomeSourceEntityAdapter());
    await Hive.initFlutter();
    await UserData.init();
    await UserThemePreferences.init();
    await ExpenseCategoriesStorage.init();
    await IncomeSourceStorage.init();
    await IncomeStorage.init();
  }
}
