import 'dart:convert';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:speakup/models/user.dart';
import 'package:speakup/provider/user_provider.dart';

import 'package:speakup/services/auth/firebase_auth_provider.dart';
import 'package:speakup/utils/app_route_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SpeakupUser? userInfo;
  late SharedPreferences prefs;
  var user = FirebaseAuthProvider().currentUser;

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      asyncNavigationCallback: () async {
        //!check if user is signed in and takes to appropriate screen
        var userInfo = Provider.of<UserInfoProvider>(context, listen: false);
        var nav = Navigator.of(context);
        prefs = await SharedPreferences.getInstance();
        await Future.delayed(const Duration(seconds: 1));
        // Retrieving object
        String? jsonString = prefs.getString('userDetails');
        if (jsonString != null) {
          var userDetails =
              SpeakupUser.fromSpeakupUserMap(json.decode(jsonString));
          userInfo.setUser(userDetails);
        }

        user == null || userInfo.user == null
            ? nav.popAndPushNamed(AppRouteConstants.getStartedRouteName)
            : nav.popAndPushNamed(AppRouteConstants.homeRouteName);
      },
      backgroundColor: const Color(0xFF440d56),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () async {
        debugPrint("On End");
      },
      childWidget: const SizedBox(
        height: 200,
        width: 200,
        child: CircleAvatar(
          backgroundImage: AssetImage("images/speakup.png"),
        ),
      ),
      onAnimationEnd: () {
        debugPrint("On Fade In End");
        debugPrint(user?.email);
        debugPrint(userInfo?.email);
      },
    );
  }
}
