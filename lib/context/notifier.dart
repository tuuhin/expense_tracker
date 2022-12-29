import 'package:flutter/material.dart';

class Notifier<T> extends ChangeNotifier {
  final List<T> _selected = [];
  List<T> get selected => _selected;

  bool isThere(T model) => _selected.contains(model);

  void check(T model) {
    isThere(model) ? _selected.remove(model) : _selected.add(model);
    notifyListeners();
  }

  void addBulk(List<T> models) {
    _selected.addAll(models);
    notifyListeners();
  }

  void clear() {
    _selected.clear();
    notifyListeners();
  }
}
