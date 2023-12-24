import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speakup/models/user.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
import 'package:speakup/screens/home/conversation.dart';
import 'package:speakup/services/auth/firebase_auth_provider.dart';
import 'package:speakup/services/cloud/firebase_cloud.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SpeakupUser? userInfo;

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuthProvider().currentUser;

    return FlutterSplashScreen.fadeIn(
      duration: Duration(seconds: 5),
      backgroundColor: const Color(0xFF440d56),
      onInit: () async {
        debugPrint("On Init");
        SpeakupUser? user = await FirebaseCloud().getCurrentUser();
        if (user != null) {
          Provider.of<UserInfoProvider>(context, listen: false).setUser(user);
        }
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
      // nextScreen: const GetStartedScreen(),
      nextScreen:
          user == null ? const GetStartedScreen() : const ConversationScreen(),
    );
  }
}
