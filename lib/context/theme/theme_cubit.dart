import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/local/storage.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._themePreferences) : super(ThemeState.system());

  final ThemePreferences _themePreferences;

  ThemeMode get themeMode => _themePreferences.getThemeMode();

  ThemeEnum get themeEnum => _themePreferences.toEnum(themeMode);

  void changeTheme(ThemeEnum? mode) async {
    if (mode == null) return;
    await _themePreferences.setThemeMode(mode);
    switch (themeMode) {
      case ThemeMode.light:
        return emit(ThemeState.light());
      case ThemeMode.dark:
        return emit(ThemeState.dark());
      default:
        return emit(ThemeState.system());
    }
  }
}
