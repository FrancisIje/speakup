import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:speakup/screens/signup/names.dart' show emailTextController;
import 'package:speakup/services/auth/auth_exceptions.dart';

import 'package:speakup/services/auth/auth_service.dart';
import 'package:speakup/utils/app_route_const.dart';

class PasswordSetScreen extends StatefulWidget {
  const PasswordSetScreen({super.key});

  @override
  State<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

bool obsureText = true;

late TextEditingController passwordTextController;
late TextEditingController confirmPasswordTextController;

void runAuth(BuildContext context) async {
  var navigation = Navigator.of(context);
  try {
    await AuthService.firebase().createUser(
        email: emailTextController.text, password: passwordTextController.text);

    await FirebaseAuth.instance.currentUser!.sendEmailVerification();

    navigation.popAndPushNamed(AppRouteConstants.verifybuilderRouteName);
  } catch (e) {
    switch (e) {
      case WeakPasswordAuthException():
        Fluttertoast.showToast(
            msg: "Passwords should be 6 Characters or more",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[200],
            textColor: Colors.white,
            fontSize: 16.0);
      case EmailAlreadyInUseAuthException():
        Fluttertoast.showToast(
            msg: "Email already in use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[200],
            textColor: Colors.white,
            fontSize: 16.0);
      case InvalidEmailAuthException():
        Fluttertoast.showToast(
            msg: "Invalid email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[200],
            textColor: Colors.white,
            fontSize: 16.0);
    }
    debugPrintStack(label: e.toString());
  }
}

class _PasswordSetScreenState extends State<PasswordSetScreen> {
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
  }

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
                      if (_passwordFormKey.currentState!.validate()) {
                        runAuth(context);
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
