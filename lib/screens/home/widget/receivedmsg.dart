import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:speakup/provider/audio_state_provider.dart';
import 'package:speakup/provider/text_word_switch.dart';

import 'package:speakup/provider/tooltip_provider.dart';
import 'package:speakup/provider/user_provider.dart';

import 'package:speakup/services/gpt/gpt.dart';
import 'package:speakup/utils/responsive.dart';

//!Received message widget displays the ui of the messages received from the ai

class ReceivedMsg extends StatefulWidget {
  final String msg;
  final OverlayPortalController tooltipController;

  const ReceivedMsg(
      {super.key, required this.msg, required this.tooltipController});

  @override
  State<ReceivedMsg> createState() => _ReceivedMsgState();
}

class _ReceivedMsgState extends State<ReceivedMsg> {
  List<String>? wordsToAddList;
  double dxPosition = 0;
  double dyPosition = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInfoProvider>(context);
    List<String> words = widget.msg.split(' ');

    //show tooltip
    void showTooltip(
        BuildContext context, String word, TapDownDetails details) {
      Provider.of<TextWordProvider>(context, listen: false)
          .toggleSelection(isText: true);
      TooltipProvider tooltipProvider =
          Provider.of<TooltipProvider>(context, listen: false);

      if (!tooltipProvider.isTooltipVisible) {
        tooltipProvider.showTooltip(
          context,
          word,
          details,
          user.user!.targetLanguage,
          user.user!.nativeLanguage,
        );
      }
    }

    //hide tooltip
    void hideTooltip(BuildContext context) {
      TooltipProvider tooltipProvider =
          Provider.of<TooltipProvider>(context, listen: false);

      if (tooltipProvider.isTooltipVisible) {
        tooltipProvider.hideTooltip(context);
      }
    }

    //build the chat response so they can be tap able

    List<Widget> buildTextSpans(List<String> words) {
      List<Widget> textSpans = [];

      for (String word in words) {
        textSpans.add(GestureDetector(
            onTapDown: (details) {
              setState(() {
                hideTooltip(context);
                showTooltip(context, word, details);
              });
            },
            child: Text("$word ")));
      }

      return textSpans;
    }

    return GestureDetector(
      onPanUpdate: (details) {
        //hide tooltip when sudden small taps are made on the screen
        Provider.of<TooltipProvider>(context, listen: false)
            .hideTooltip(context);
      },
      onTap: () {
        //hide tooltip when taps are made on the screen
        Provider.of<TooltipProvider>(context, listen: false)
            .hideTooltip(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<AudioProvider>(
                  builder: (context, value, child) => !value.isTalking
                      ? IconButton(
                          onPressed: () async {
                            var audioProvider = Provider.of<AudioProvider>(
                                context,
                                listen: false);
                            await ChatGPTApi(context).fetchSpeech(widget.msg);

                            audioProvider.changeTalkingBool(true);
                          },
                          icon: const Icon(Icons.volume_mute_outlined))
                      : IconButton(
                          onPressed: () {
                            //changes the audio playing state
                            debugPrint("tallkkk");
                            Provider.of<AudioProvider>(context, listen: false)
                              ..changeTalkingBool(false)
                              ..stopAudio();
                          },
                          icon: const Icon(Icons.volume_up_outlined)),
                ),
                SizedBox(
                  height: 15.h,
                ),
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
                      // height: 400.h,
                      constraints:
                          BoxConstraints(maxWidth: appWidth(context) * 0.6),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                      color: Colors.white,
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 10,
                        children: [
                          ...buildTextSpans(words).map((e) {
                            return e;
                          })
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
