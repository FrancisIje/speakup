import 'package:flutter/material.dart';
import 'package:speakup/screens/home/widget/receivedmsg.dart';
import 'package:speakup/screens/home/widget/sentmsg.dart';

class ChatMessage extends StatefulWidget {
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
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  late OverlayPortalController _tooltipController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipController = OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) {
    return widget.role == "user"
        ? SentMsg(msg: widget.text)
        : ReceivedMsg(
            key: UniqueKey(),
            msg: widget.text,
            tooltipController: _tooltipController,
          );
  }
}
