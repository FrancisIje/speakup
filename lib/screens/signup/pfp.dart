import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class ProfilePicScreen extends StatefulWidget {
  const ProfilePicScreen({super.key});

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
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
                      "ADD YOUR PROFILE \nPICTURE!",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Center(
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 250.h,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                    right: Radius.circular(40)))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload from files",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Icon(
                            Icons.image_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                    right: Radius.circular(40)))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Take a picture",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: appHeight(context) * 0.18,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('logged in');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(104, 73, 255, 1)),
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                    right: Radius.circular(40)))),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Align(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
