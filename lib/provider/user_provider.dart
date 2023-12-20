import 'package:flutter/material.dart';
import 'package:speakup/models/user.dart';

class UserInfoProvider extends ChangeNotifier {
  SpeakupUser? _user;

  SpeakupUser? get user => _user;

  void setUser(SpeakupUser? user) {
    _user = user;
    notifyListeners();
  }
}
