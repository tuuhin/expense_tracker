import 'package:hive/hive.dart';

class UserData {
  static final _box = Hive.box('userdata');

  bool? getThemeData() => _box.get('theme');

  void setTheme(bool isDark) => _box.put('theme', isDark);
}
