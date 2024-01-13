import 'package:flutter/material.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';

class ChatMessageProvider extends ChangeNotifier {
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void insertMessage(ChatMessage message) {
    _messages.insert(0, message);
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => notifyListeners());
  }

  void resetMessage() {
    _messages = [];
    notifyListeners();
  }
}
