import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class SignUp1Screen extends StatefulWidget {
  const SignUp1Screen({super.key});

  @override
  State<SignUp1Screen> createState() => _SignUp1ScreenState();
}

class _SignUp1ScreenState extends State<SignUp1Screen> {
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
                      "HELP US GET TO KNOW \nYOU!",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          return 'Enter first name';
                        } else {
                          return null;
                        }
                      },
                      controller: emailTextController,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "First Name",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          return 'Enter last name';
                        } else {
                          return null;
                        }
                      },
                      controller: emailTextController,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Last Name",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          return 'Enter email';
                        } else {
                          return null;
                        }
                      },
                      controller: emailTextController,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Email address",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)))),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          return 'Enter phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordTextController,
                      obscureText: obsureText,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Phone number",
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obsureText = !obsureText;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye_outlined)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)))),
                    ),
                    SizedBox(
                      height: appHeight(context) * 0.28,
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
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
