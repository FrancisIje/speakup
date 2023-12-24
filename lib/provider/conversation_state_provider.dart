import 'package:flutter/material.dart';

class ConversationStateProvider extends ChangeNotifier {
  bool _isRolePlay = false;
  bool _isParagraph = false;
  bool _isFree = false;

  bool get isRolePlay => _isRolePlay;
  bool get isParagraph => _isParagraph;
  bool get isFree => _isFree;

  set isRolePlay(bool value) {
    _isRolePlay = value;
    if (value) {
      _isParagraph = false;
      _isFree = false;
    }
    notifyListeners();
  }

  set isParagraph(bool value) {
    _isParagraph = value;
    if (value) {
      _isRolePlay = false;
      _isFree = false;
    }
    notifyListeners();
  }

  set isFree(bool value) {
    _isFree = value;
    if (value) {
      _isRolePlay = false;
      _isParagraph = false;
    }
    notifyListeners();
  }
}
