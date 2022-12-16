import 'package:flutter/cupertino.dart';

import '../main.dart';

class Notifier<T> extends ChangeNotifier {
  final List<T> _selected = [];
  List<T> get selected => _selected;

  bool isThere(T model) => _selected.contains(model);

  void check(T model) {
    isThere(model) ? _selected.remove(model) : _selected.add(model);
    notifyListeners();
  }

  void clear() {
    _selected.clear();
    logger.info('clearing');
    notifyListeners();
  }
}
