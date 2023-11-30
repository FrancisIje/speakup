import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obsureText = true;
  void navToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouteConstants.homeRouteName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VERIFY EMAIL",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "We’ve sent  you a link to verify your Email Address. Please check your email. \n \nIn case you don’t find the link in your inbox. Kindly check your spam folder",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 54.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Didn't get the link?",
                          style: TextStyle(
                              color: const Color.fromRGBO(104, 73, 255, 1),
                              fontStyle: FontStyle.italic,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const GetStartedScreen(),
                            // ));
                          },
                          child: Text(
                            "Resend in 30 seconds",
                            style: TextStyle(
                                color: const Color.fromRGBO(104, 73, 255, 1),
                                fontSize: 14.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: appHeight(context) * 0.28,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
