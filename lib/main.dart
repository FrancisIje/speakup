import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/firebase_options.dart';
import 'package:speakup/provider/is_talking.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/provider/widget_switch.dart';
import 'package:speakup/screens/definition/definition_screen.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
// import 'package:provider/provider.dart';
import 'package:speakup/screens/login/loginscreen.dart';
import 'package:speakup/screens/signup/passwords.dart';
import 'package:speakup/screens/signup/pfp.dart';
import 'package:speakup/screens/signup/verify.dart';
import 'package:speakup/screens/signup/verify_builder.dart';
import 'package:speakup/screens/splash/splashscreen.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SpeakUpApp());
}

class SpeakUpApp extends StatelessWidget {
  const SpeakUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ToggleProvider>(
                create: (context) => ToggleProvider(),
              ),
              ChangeNotifierProvider<Talking>(
                create: (context) => Talking(),
              ),
              ChangeNotifierProvider<UserInfoProvider>(
                create: (context) => UserInfoProvider(),
              ),
            ],
            child: MaterialApp(
              routes: {
                AppRouteConstants.loginRouteName: (context) =>
                    const LoginScreen(),
                AppRouteConstants.getStartedRouteName: (context) =>
                    const GetStartedScreen(),
                AppRouteConstants.picUploadRouteName: (context) =>
                    const ProfilePicScreen(),
                AppRouteConstants.verifyemailRouteName: (context) =>
                    const VerifyEmailScreen(),
                AppRouteConstants.verifybuilderRouteName: (context) =>
                    const VerifyBuilder(),
                AppRouteConstants.definitionScreenRouteName: (context) =>
                    const DefinitionScreen(),
                AppRouteConstants.passwordScreenRouteName: (context) =>
                    const PasswordSetScreen(),
                // AppRouteConstants.onboarding5RouteName: (context) =>
                //     const OnboardingScreen5(),
                // AppRouteConstants.homeRouteName: (context) => const Home(),
              },
              theme: appThemeData,
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
