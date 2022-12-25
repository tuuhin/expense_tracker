import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeEnum { light, dark, system }

class ThemePreferences {
  static late final SharedPreferences? _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  ThemeMode getThemeMode() {
    String? mode = _pref!.getString("theme");
    switch (mode) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeEnum toEnum(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        return ThemeEnum.light;
      case ThemeMode.dark:
        return ThemeEnum.dark;
      default:
        return ThemeEnum.system;
    }
  }

  Future<void> setThemeMode(ThemeEnum mode) async {
    switch (mode) {
      case ThemeEnum.dark:
        await _pref!.setString('theme', "dark");
        break;
      case ThemeEnum.light:
        await _pref!.setString('theme', "light");
        break;
      case ThemeEnum.system:
        await _pref!.setString('theme', "system");
        break;
      default:
    }
    return;
  }
}
