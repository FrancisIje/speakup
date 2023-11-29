import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
import 'package:speakup/screens/login/loginscreen.dart';
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
              // AppRouteConstants.onboarding1RouteName: (context) =>
              //     const OnboardingScreen1(),
              // AppRouteConstants.onboarding4RouteName: (context) =>
              //     const OnboardingScreen4(),
              // AppRouteConstants.onboarding3RouteName: (context) =>
              //     const OnboardingScreen3(),
              // AppRouteConstants.onboarding2RouteName: (context) =>
              //     const OnboardingScreen2(),
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
