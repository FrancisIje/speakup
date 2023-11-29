import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:speakup/screens/login/loginscreen.dart';

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
      backgroundColor: Colors.white,
      onInit: () async {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("images/speakup.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const LoginScreen(),
      // nextScreen: user == null ? const LoginScreen() : const Home(),
    );
  }
}
