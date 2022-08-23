import 'package:expense_tracker/domain/enums/theme_enum.dart';
import 'package:expense_tracker/domain/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserThemePreferences implements UserThemePreferencesRepostiory {
  static Box? _userPref;
  static const String userPreferencesBox = 'user_prefrences';
  static Future init() async {
    _userPref = await Hive.openBox(userPreferencesBox);
  }

  @override
  ThemeEnum getThemeEnum() => _userPref!.get('theme') ?? ThemeEnum.system;

  ThemeMode getThemeMode() {
    ThemeEnum mode = getThemeEnum();

    switch (mode) {
      case ThemeEnum.light:
        return ThemeMode.light;
      case ThemeEnum.dark:
        return ThemeMode.dark;
      case ThemeEnum.system:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeEnum mode) async {
    switch (mode) {
      case ThemeEnum.dark:
        await _userPref!.put('theme', ThemeEnum.dark);
        break;
      case ThemeEnum.light:
        await _userPref!.put('theme', ThemeEnum.light);
        break;
      case ThemeEnum.system:
        await _userPref!.put('theme', ThemeEnum.system);
        break;
      default:
    }
  }
}
