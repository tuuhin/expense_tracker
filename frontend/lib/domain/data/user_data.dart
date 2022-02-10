import 'package:hive/hive.dart';

class UserData {
  static final Future<Box> _box = Hive.openBox('userdata');
}
