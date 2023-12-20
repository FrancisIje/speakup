import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/widget_switch.dart';
import 'package:speakup/services/gpt/gpt.dart';
import 'package:speakup/utils/responsive.dart';

class ReceivedMsg extends StatelessWidget {
  final String msg;
  const ReceivedMsg({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
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
                          ChatGPTApi(context).fetchSpeech(msg);
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
                    ChatGPTApi(context).fetchSpeech(msg);
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
                  // height: 120.h,
                  color: Colors.white,
                  child: Text(
                    msg,
                    softWrap: true,
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
