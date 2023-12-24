import 'package:flutter/material.dart';

class TextWordProvider extends ChangeNotifier {
  bool _isText = false;

  bool get isText => _isText;

  void toggleSelection() {
    _isText = !_isText;
    notifyListeners();
  }
}
