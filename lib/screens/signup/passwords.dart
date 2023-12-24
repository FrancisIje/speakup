import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:speakup/screens/signup/names.dart' show emailTextController;

import 'package:speakup/services/auth/auth_service.dart';
import 'package:speakup/utils/app_route_const.dart';

class PasswordSetScreen extends StatefulWidget {
  const PasswordSetScreen({super.key});

  @override
  State<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

bool obsureText = true;

final passwordTextController = TextEditingController();
final confirmPasswordTextController = TextEditingController();

void runAuth() async {
  try {
    await AuthService.firebase().createUser(
        email: emailTextController.text, password: passwordTextController.text);

    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  } catch (e) {
    print(e);
  }
}

class _PasswordSetScreenState extends State<PasswordSetScreen> {
  final _passwordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Form(
              key: _passwordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SET YOUR PASSWORD",
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Kindly enter and confirm your password to \ncontinue",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    obscureText: obsureText,
                    controller: passwordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password';
                      } else {
                        return null;
                      }
                    },

                    // controller: emailTextController,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Color(0xFF777777)),
                        hintText: "Enter password",
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsureText = !obsureText;
                              });
                            },
                            child: Icon(Icons.remove_red_eye_outlined)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.r)))),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  TextFormField(
                    controller: confirmPasswordTextController,
                    obscureText: obsureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password again';
                      }
                      if (value != passwordTextController.text) {
                        return "Passwords do not match";
                      } else {
                        return null;
                      }
                    },
                    // controller: emailTextController,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Color(0xFF777777)),
                        hintText: "Confirm password",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.r)))),
                  ),
                  const Expanded(child: SizedBox()),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const LanguageScreen(),
                      // ));

                      if (_passwordFormKey.currentState!.validate()) {
                        runAuth();
                        Navigator.of(context).popAndPushNamed(
                            AppRouteConstants.verifybuilderRouteName);
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
                    height: 60.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
