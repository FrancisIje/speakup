import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
// import 'package:provider/provider.dart';
import 'package:speakup/screens/login/loginscreen.dart';
import 'package:speakup/screens/signup/pfp.dart';
import 'package:speakup/screens/signup/verify.dart';
import 'package:speakup/screens/signup/verify_builder.dart';
import 'package:speakup/screens/splash/splashscreen.dart';
import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/theme.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          return MaterialApp(
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
              // AppRouteConstants.onboarding5RouteName: (context) =>
              //     const OnboardingScreen5(),
              // AppRouteConstants.homeRouteName: (context) => const Home(),
            },
            theme: appThemeData,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
