import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:speakup/screens/signup/pfp.dart';
// import 'package:speakup/services/auth/auth_provider.dart';
// import 'package:speakup/services/auth/auth_service.dart';

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
    // Listen to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // print(user!.email);
      // print(user.emailVerified);
      // user.reload();

      // Check if the user is signed in and email is verified
      if (user != null && user.emailVerified) {
        // Navigate to the profile pic screen when email is verified
        Navigator.of(context)
            .pushReplacementNamed(AppRouteConstants.picUploadRouteName);
      }
    });
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
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser!.reload();
                        setState(() {});
                      },
                      icon: Icon(Icons.refresh_outlined),
                    ),
                    Text("Reload screen"),
                    SizedBox(
                      height: 34.h,
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
                            // AuthService.firebase().logOut();
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
