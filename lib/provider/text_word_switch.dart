import 'package:flutter/material.dart';

class TextWordProvider extends ChangeNotifier {
  bool _isText = true;

  bool get isText => _isText;

  void toggleSelection({required bool isText}) {
    _isText = isText;
    notifyListeners();
  }
}
