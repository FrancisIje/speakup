import 'package:flutter/material.dart';
import 'package:speakup/screens/home/widget/receivedmsg.dart';
import 'package:speakup/screens/home/widget/sentmsg.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String role;

  ChatMessage({required this.text, required this.role});

  @override
  Widget build(BuildContext context) {
    return role == "user" ? SentMsg(msg: text) : ReceivedMsg(msg: text);
  }
}
