import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:speakup/screens/get_started/getstarted.dart';

import 'package:speakup/screens/login/loginscreen.dart';
import 'package:speakup/screens/signup/names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // var user = FirebaseAuthProvider().currentUser;
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color(0xFF440d56),
      onInit: () async {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: const SizedBox(
        height: 200,
        width: 200,
        child: CircleAvatar(
          backgroundImage: AssetImage("images/speakup.png"),
        ),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const GetStartedScreen(),
      // nextScreen: user == null ? const LoginScreen() : const Home(),
    );
  }
}
