import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
import 'package:speakup/screens/home/conversation.dart';
import 'package:speakup/services/auth/auth_service.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      "WELCOME BACK!",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Enter your email and password to \ncontinue",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        height: appHeight(context) * 0.37,
                        width: double.maxFinite,
                        child: Image.asset(
                          "images/womanpurple.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
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
                        if (value == null) {
                          return 'Enter password';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordTextController,
                      obscureText: obsureText,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Password",
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
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // AuthService.firebase().sendPasswordReset(toEmail: toEmail)
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontSize: 14.sp, fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('logged in');

                          AuthService.firebase()
                              .logIn(
                                  email: emailTextController.text,
                                  password: passwordTextController.text)
                              .then((value) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ConversationScreen(),
                                  )));
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
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: const Color.fromRGBO(104, 73, 255, 1),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const GetStartedScreen(),
                            ));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: const Color.fromRGBO(104, 73, 255, 1),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
