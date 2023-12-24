import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:speakup/provider/tooltip_provider.dart';
import 'package:speakup/provider/widget_switch.dart';

import 'package:speakup/services/gpt/gpt.dart';
import 'package:speakup/utils/responsive.dart';

class ReceivedMsg extends StatefulWidget {
  final String msg;

  ReceivedMsg({Key? key, required this.msg});

  @override
  State<ReceivedMsg> createState() => _ReceivedMsgState();
}

OverlayEntry? currentTooltipOverlay;

class _ReceivedMsgState extends State<ReceivedMsg> {
  @override
  Widget build(BuildContext context) {
    List<String> words = widget.msg.split(' ');

    void showTooltip(
        BuildContext context, String word, TapDownDetails details) {
      TooltipProvider tooltipProvider =
          Provider.of<TooltipProvider>(context, listen: false);

      if (!tooltipProvider.isTooltipVisible) {
        tooltipProvider.showTooltip(context, word, details);
      }
    }

    void hideTooltip(BuildContext context) {
      TooltipProvider tooltipProvider =
          Provider.of<TooltipProvider>(context, listen: false);

      if (tooltipProvider.isTooltipVisible) {
        tooltipProvider.hideTooltip(context);
      }
    }

    List<TextSpan> buildTextSpans(List<String> words) {
      List<TextSpan> textSpans = [];

      for (String word in words) {
        textSpans.add(
          TextSpan(
            text: " $word ",
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            recognizer: TapGestureRecognizer()
              ..onTapDown = (details) {
                hideTooltip(context);
                showTooltip(context, word, details);
              }
              ..onTapCancel = () {
                hideTooltip(context);
              },
          ),
        );
      }

      return textSpans;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<ToggleProvider>(
                builder: (context, value, child) => value.isFirstWidgetSelected
                    ? IconButton(
                        onPressed: () {
                          ChatGPTApi(context).fetchSpeech(widget.msg);
                          Provider.of<ToggleProvider>(context, listen: false)
                              .toggleSelection();
                        },
                        icon: const Icon(Icons.volume_mute_outlined))
                    : IconButton(
                        onPressed: () {
                          debugPrint("tallkkk");
                          Provider.of<ToggleProvider>(context, listen: false)
                              .toggleSelection();
                        },
                        icon: const Icon(Icons.volume_up_outlined)),
              ),
              IconButton(
                  onPressed: () {
                    ChatGPTApi(context).fetchSpeech(widget.msg);
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Color.fromRGBO(104, 73, 255, 1),
                  )),
              const CircleAvatar(
                backgroundImage: AssetImage("images/womanpurple.png"),
              ),
            ],
          ),
          SizedBox(
            width: 4.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: appWidth(context) * 0.6),
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  color: Colors.white,
                  child: RichText(
                    text: TextSpan(
                      children: buildTextSpans(words),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
