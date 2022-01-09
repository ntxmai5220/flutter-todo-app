import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier {
  bool _view = true;
  late bool _update;

  bool get isView => _view;
  bool get isUpdate => _update;

  void toggleState() {
    _view = !_view;
    notifyListeners();
  }

  void setMode(bool isUpdate) {
    _update = isUpdate;
    notifyListeners();
  }
}
