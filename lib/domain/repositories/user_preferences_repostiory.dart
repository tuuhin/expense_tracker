import 'package:flutter/material.dart';

abstract class UserPreferencesRepostiory {
  ThemeMode getThemeMode();

  void setThemeMode(ThemeMode mode);
}
