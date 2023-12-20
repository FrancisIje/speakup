import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:speakup/screens/signup/pfp.dart';
import 'package:speakup/screens/signup/verify.dart';

class VerifyBuilder extends StatefulWidget {
  const VerifyBuilder({super.key});

  @override
  State<VerifyBuilder> createState() => _VerifyBuilderState();
}

Future<bool> checkUserEmailVerified() async {
  bool isVerified = false;
  try {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        if (user.emailVerified) {
          // Email is verified
          isVerified = true;
        } else {
          // Email is not verified
          isVerified = false;
        }
      } else {
        // User is signed out.
        isVerified = false;
      }
    });
    return isVerified;
  } catch (e) {
    print("Error checking user email verification: $e");
    return false; // Error occurred while checking email verification
  }
}

class _VerifyBuilderState extends State<VerifyBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkUserEmailVerified(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const VerifyEmailScreen();

          case ConnectionState.active:
          case ConnectionState.done:
            print(snapshot.data);
            return snapshot.data == true
                ? const ProfilePicScreen()
                : const VerifyEmailScreen();
        }
      },
    );
  }
}
