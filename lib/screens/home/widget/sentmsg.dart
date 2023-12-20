import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1504203772830-87fba72385ee?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Ym95fGVufDB8fDB8fHww"),
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
