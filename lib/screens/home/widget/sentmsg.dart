import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/utils/responsive.dart';

class SentMsg extends StatelessWidget {
  final String msg;
  const SentMsg({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(Provider.of<UserInfoProvider>(context)
                    .user
                    ?.profilePictureUrl ??
                ""),
          ),
          SizedBox(
            width: 3.w,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r)),
            child: Container(
              constraints: BoxConstraints(maxWidth: appWidth(context) * 0.6),
              padding: const EdgeInsets.all(4),
              color: const Color.fromRGBO(104, 73, 255, 1),
              child: Text(
                msg,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 255, 255, 0.75)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
