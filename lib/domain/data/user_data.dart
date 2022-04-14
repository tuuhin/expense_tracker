import 'package:hive_flutter/hive_flutter.dart';

class UserData {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('userdata');
  }

  static final _box = Hive.box('userdata');

  bool? getThemeData() => _box.get('theme');

  void setTheme(bool isDark) => _box.put('theme', isDark);
}
