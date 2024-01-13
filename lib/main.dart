import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/firebase_options.dart';
import 'package:speakup/provider/audio_state_provider.dart';
import 'package:speakup/provider/chat_message.dart';
import 'package:speakup/provider/conversation_state_provider.dart';
import 'package:speakup/provider/is_chat_hidden.dart';

import 'package:speakup/provider/text_word_switch.dart';
import 'package:speakup/provider/tooltip_provider.dart';
import 'package:speakup/provider/user_provider.dart';

import 'package:speakup/provider/vtt_filepath.dart';

import 'package:speakup/provider/words_to_voc.dart';
import 'package:speakup/screens/definition/definition_screen.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
import 'package:speakup/screens/home/conversation.dart';
import 'package:speakup/screens/home/voctest.dart';

import 'package:speakup/screens/login/loginscreen.dart';
import 'package:speakup/screens/settings/contact_us.dart';
import 'package:speakup/screens/settings/delete_account.dart';
import 'package:speakup/screens/settings/faq.dart';
import 'package:speakup/screens/settings/personal_details.dart';
import 'package:speakup/screens/settings/send_review.dart';
import 'package:speakup/screens/settings/speech_controller.dart';
import 'package:speakup/screens/settings/subscription.dart';
import 'package:speakup/screens/settings/terms.dart';
import 'package:speakup/screens/signup/passwords.dart';
import 'package:speakup/screens/signup/pfp.dart';
import 'package:speakup/screens/signup/verify.dart';
import 'package:speakup/screens/signup/verify_builder.dart';
import 'package:speakup/screens/splash/splashscreen.dart';
import 'package:speakup/screens/vocabulary/vocabulary_screen.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
              ChangeNotifierProvider<AudioProvider>(
                create: (context) => AudioProvider(),
              ),
              ChangeNotifierProvider<UserInfoProvider>(
                create: (context) => UserInfoProvider(),
              ),
              ChangeNotifierProvider<TextWordProvider>(
                create: (context) => TextWordProvider(),
              ),
              ChangeNotifierProvider<TooltipProvider>(
                create: (context) => TooltipProvider(),
              ),
              // ChangeNotifierProvider<VttFilePathProvider>(
              //   create: (context) => VttFilePathProvider(),
              // ),
              ChangeNotifierProvider<ChatMessageProvider>(
                create: (context) => ChatMessageProvider(),
              ),
              ChangeNotifierProvider<ConversationStateProvider>(
                create: (context) => ConversationStateProvider(),
              ),
              ChangeNotifierProvider<IsChatVisibleProvider>(
                create: (context) => IsChatVisibleProvider(),
              ),
              ChangeNotifierProvider<WordsProvider>(
                create: (context) => WordsProvider(),
              ),
            ],
            child: MaterialApp(
              routes: {
                AppRouteConstants.homeRouteName: (context) =>
                    const ConversationScreen(),
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
                // AppRouteConstants.definitionScreenRouteName: (context) =>
                //     const DefinitionScreen(),
                AppRouteConstants.passwordScreenRouteName: (context) =>
                    const PasswordSetScreen(),
                AppRouteConstants.personalDetailsRouteName: (context) =>
                    const PersonalDetailsPage(),
                AppRouteConstants.speechControllerRouteName: (context) =>
                    const SpeechControllerPage(),
                AppRouteConstants.reviewRouteName: (context) =>
                    const ReviewPage(),
                AppRouteConstants.deleteaccountRouteName: (context) =>
                    const DeleteAccountPage(),
                AppRouteConstants.subscriptionRouteName: (context) =>
                    const SubscriptionScreen(),
                AppRouteConstants.termsRouteName: (context) =>
                    const TermsAndConditionsScreen(),
                AppRouteConstants.contactUsRouteName: (context) =>
                    const ContactUsScreen(),
                AppRouteConstants.faqRouteName: (context) => const FaqScreen(),
                AppRouteConstants.vocTestRouteName: (context) =>
                    const VocTest(),
                AppRouteConstants.vocabularyRouteName: (context) =>
                    const VocabularyScreen(),
              },
              theme: appThemeData,
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
