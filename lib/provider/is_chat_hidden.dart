import 'package:flutter/material.dart';

class IsChatVisibleProvider extends ChangeNotifier {
  bool _isChatVisible = true;

  bool get isChatVisible => _isChatVisible;

  void toggleChatVisibility() {
    _isChatVisible = !_isChatVisible;
    notifyListeners();
  }
}
