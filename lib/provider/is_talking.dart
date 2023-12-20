import 'package:flutter/material.dart';

class Talking with ChangeNotifier {
  bool _isTalking = false;

  bool get isTalking => _isTalking;

  void changeTalkingBool(bool isTalking) {
    _isTalking = isTalking;
    notifyListeners();
  }
}
