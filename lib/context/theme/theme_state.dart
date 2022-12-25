part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  factory ThemeState.light() = _Light;
  factory ThemeState.dark() = _Dark;
  factory ThemeState.system() = _System;
}
