import 'package:expense_tracker/domain/enums/theme_enum.dart';

abstract class UserThemePreferencesRepostiory {
  ThemeEnum getThemeEnum();

  Future<void> setThemeMode(ThemeEnum mode);
}
