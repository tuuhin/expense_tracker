import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/local/storage.dart';
import 'package:expense_tracker/domain/enums/theme_enum.dart';
import 'package:flutter/material.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeSystem());
  static final UserThemePreferences _userThemePreferences =
      UserThemePreferences();

  ThemeMode _themeMode = _userThemePreferences.getThemeMode();
  ThemeEnum _themeEnum = _userThemePreferences.getThemeEnum();
  ThemeMode get themeMode => _themeMode;
  ThemeEnum get themeEnum => _themeEnum;

  void changeTheme(ThemeEnum mode) async {
    await _userThemePreferences.setThemeMode(mode);
    _themeMode = _userThemePreferences.getThemeMode();
    _themeEnum = mode;
    switch (mode) {
      case ThemeEnum.light:
        return emit(ThemeLight());
      case ThemeEnum.dark:
        return emit(ThemeDark());
      case ThemeEnum.system:
        return emit(ThemeSystem());
      default:
    }
  }
}
