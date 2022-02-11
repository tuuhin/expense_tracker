import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/data/user_data.dart';
import 'package:meta/meta.dart';

part 'themecubit_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());
  static final UserData _user = UserData();

  bool _isDark = _user.getThemeData() ?? false;
  bool get isDark => _isDark;

  void changeTheme() {
    _isDark = !_isDark;
    _user.setTheme(_isDark);
    if (_isDark) return emit(ThemeDark());
    return emit(ThemeLight());
  }
}
