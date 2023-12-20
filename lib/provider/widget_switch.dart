import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  bool _isFirstWidgetSelected = true;

  bool get isFirstWidgetSelected => _isFirstWidgetSelected;

  void toggleSelection() {
    _isFirstWidgetSelected = !_isFirstWidgetSelected;
    notifyListeners();
  }
}
