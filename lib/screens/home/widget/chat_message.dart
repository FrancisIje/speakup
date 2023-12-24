import 'package:flutter/material.dart';
import 'package:speakup/screens/home/widget/receivedmsg.dart';
import 'package:speakup/screens/home/widget/sentmsg.dart';

class ChatMessage extends StatelessWidget {
  // final String id;
  final String text;
  final String role;

  const ChatMessage({
    super.key,
    required this.text,
    required this.role,
    // required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return role == "user" ? SentMsg(msg: text) : ReceivedMsg(msg: text);
  }
}
