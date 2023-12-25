import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

late TextEditingController emailTextController;
late TextEditingController firstNameTextController;
late TextEditingController lastNameTextController;
late TextEditingController phoneNumTextController;

class SignUp1Screen extends StatefulWidget {
  const SignUp1Screen({super.key});

  @override
  State<SignUp1Screen> createState() => _SignUp1ScreenState();
}

class _SignUp1ScreenState extends State<SignUp1Screen> {
  final _formKey = GlobalKey<FormState>();

  bool isEmailValid(String email) {
    // Define a regular expression for a simple email validation
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    // Check if the email matches the regular expression
    return emailRegExp.hasMatch(email);
  }

  void navToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouteConstants.homeRouteName, (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailTextController = TextEditingController();
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    phoneNumTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    phoneNumTextController.dispose();
    // TODO: implement dispose
    super.dispose();
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
              key: _formKey,
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
                        if (value == null) {
                          return 'Enter first name';
                        } else {
                          return null;
                        }
                      },
                      controller: firstNameTextController,
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
                        if (value == null || value.isEmpty) {
                          return 'Enter last name';
                        } else {
                          return null;
                        }
                      },
                      controller: lastNameTextController,
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
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                        if (isEmailValid(value)) {
                          return null;
                        } else {
                          return "Enter a valid email";
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
                        if (value == null || value.isEmpty) {
                          return 'Enter phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: phoneNumTextController,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Phone number",
                          fillColor: Colors.white,
                          filled: true,
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
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context,
                              AppRouteConstants.passwordScreenRouteName);
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
