import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:speakup/models/user.dart';
import 'package:speakup/provider/audio_state_provider.dart';
import 'package:speakup/provider/chat_message.dart';
import 'package:speakup/provider/conversation_state_provider.dart';
import 'package:speakup/provider/is_chat_hidden.dart';

import 'package:speakup/provider/tooltip_provider.dart';

import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/provider/words_to_voc.dart';

import 'package:speakup/screens/home/widget/chat.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';
import 'package:speakup/screens/home/widget/pdf_generator.dart';
import 'package:speakup/screens/home/widget/video_player.dart';
import 'package:speakup/screens/settings/settings.dart';
import 'package:speakup/services/cloud/firebase_cloud.dart';
import 'package:speakup/services/gpt/gpt.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with TickerProviderStateMixin {
  String? topicValue;

  late final ChatGPTApi _chatGPTApi;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late AnimationController _fadeInController;
  late AnimationController _fadeOutController;

  final CountdownController _countdownController =
      CountdownController(autoStart: true);

//formats time
  String formatDuration(double seconds) {
    int totalSeconds = seconds.floor();
    int minutes = (totalSeconds / 60).floor();
    int remainingSeconds = totalSeconds % 60;

    String formattedTime =
        '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

//get user from firebase
  Future<void> getUser() async {
    var userInfo = Provider.of<UserInfoProvider>(context, listen: false);
    SpeakupUser? user = await FirebaseCloud().getCurrentUser();
    if (user != null) {
      userInfo.setUser(user);
    }
  }

//posts to firestore and selects which chat mode is selected
  void handleSubmitted(
      {required String text,
      required bool isRolePlay,
      required bool isParagraph,
      required bool isFree}) async {
    var chatMsgProvider =
        Provider.of<ChatMessageProvider>(context, listen: false);
    ChatMessage message = ChatMessage(
      text: text,
      role: "user",
    );
    chatMsgProvider.insertMessage(message);

    String response;

    try {
      if (isRolePlay) {
        response =
            await ChatGPTApi(context).startRolePlay(text, "English", "A1");
      } else if (isParagraph) {
        response =
            await ChatGPTApi(context).startRolePlay(text, "English", "A1");
      } else if (isFree) {
        response = await _chatGPTApi.getChatCompletion(
            question: text, learnLang: "English");
      } else {
        response = await _chatGPTApi.getChatCompletion(
            question: text, learnLang: "English");
      }

      ChatMessage reply = ChatMessage(
        text: response,
        role: "assistant",
      );

      chatMsgProvider.insertMessage(reply);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _chatGPTApi = ChatGPTApi(context);
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    _countdownController.onStart;

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _fadeOutController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  bool obsureText = true;
  void navToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouteConstants.homeRouteName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var wordsList = Provider.of<WordsProvider>(context).wordsToAddList;
    final userSpeakUpInfo = Provider.of<UserInfoProvider>(context).user;
    final conversationProvider =
        Provider.of<ConversationStateProvider>(context, listen: false);
    var msgToSave = Provider.of<ChatMessageProvider>(context).messages;

    return GestureDetector(
      onPanDown: (details) async {
        if (Provider.of<TooltipProvider>(context, listen: false)
                .isTooltipVisible ==
            true) {
          Provider.of<TooltipProvider>(context, listen: false)
              .hideTooltip(context);
          if (wordsList != null && wordsList.isNotEmpty) {
            var userUpdate = SpeakupUser(
                    firstName: "Broooo",
                    lastName: userSpeakUpInfo!.lastName,
                    email: userSpeakUpInfo.email,
                    phoneNumber: userSpeakUpInfo.phoneNumber,
                    targetLanguage: userSpeakUpInfo.targetLanguage,
                    targetLangLevel: userSpeakUpInfo.targetLangLevel,
                    nativeLanguage: userSpeakUpInfo.nativeLanguage,
                    profilePictureUrl: userSpeakUpInfo.profilePictureUrl,
                    tutorGender: userSpeakUpInfo.tutorGender,
                    vocWords: wordsList)
                .toSpeakupUserMap();

            await FirebaseCloud().updateUserData(userUpdate);
          }
        }
      },
      onTap: () async {
        if (Provider.of<TooltipProvider>(context, listen: false)
                .isTooltipVisible ==
            true) {
          Provider.of<TooltipProvider>(context, listen: false)
              .hideTooltip(context);
          if (wordsList != null && wordsList.isNotEmpty) {
            var userUpdate = SpeakupUser(
                    firstName: "Broooo",
                    lastName: userSpeakUpInfo!.lastName,
                    email: userSpeakUpInfo.email,
                    phoneNumber: userSpeakUpInfo.phoneNumber,
                    targetLanguage: userSpeakUpInfo.targetLanguage,
                    targetLangLevel: userSpeakUpInfo.targetLangLevel,
                    nativeLanguage: userSpeakUpInfo.nativeLanguage,
                    profilePictureUrl: userSpeakUpInfo.profilePictureUrl,
                    tutorGender: userSpeakUpInfo.tutorGender,
                    vocWords: wordsList)
                .toSpeakupUserMap();

            await FirebaseCloud().updateUserData(userUpdate);
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userSpeakUpInfo?.firstName ?? ""),
                accountEmail: Text(userSpeakUpInfo?.email ?? ""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      userSpeakUpInfo?.profilePictureUrl ?? ""),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const ImageIcon(AssetImage("images/chat_icon.png")),
                    // leading: Icon(Icons.chat_bubble_outline_rounded),
                    title: Text(
                      'Conversation',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const ImageIcon(AssetImage("images/glossary_icon.png")),
                    title: Text(
                      'Glossary',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const ImageIcon(AssetImage("images/voc_icon.png")),
                    title: Text(
                      'Vocabulary',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, AppRouteConstants.vocabularyRouteName);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const ImageIcon(AssetImage("images/voctest_icon.png")),
                    title: Text(
                      'Vocabulary Test',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, AppRouteConstants.vocTestRouteName);
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const ImageIcon(AssetImage("images/settings_icon.png")),
                    title: Text(
                      'Settings',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const ImageIcon(AssetImage("images/logout_icon.png")),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE7E3FF),
          title: const Text(
            "Conversation",
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.more_horiz)),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<IsChatVisibleProvider>(context, listen: false)
                      .toggleChatVisibility();
                },
                icon: const Icon(Icons.closed_caption_off)),
            IconButton(
                onPressed: () {
                  PdfGenerator().generateChatPdf(msgToSave);
                },
                icon: const Icon(Icons.download_rounded)),
          ],
          titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          shape: const Border(bottom: BorderSide(color: Colors.black26)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              Consumer<AudioProvider>(
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      value.isTalking
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              child: SizedBox(
                                width: appWidth(context),
                                key: const ValueKey("speaking_woman_key"),
                                child: const VideoWidget(
                                  videoPath: "videos/speaking_woman.mp4",
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              child: SizedBox(
                                width: appWidth(context),
                                key: const ValueKey("listening_woman_key"),
                                child: const VideoWidget(
                                  videoPath: "videos/listening_woman.mp4",
                                ),
                              ),
                            ),

                      ////////////////

                      Align(
                        alignment: Alignment.topLeft,
                        child: PopupMenuButton<String>(
                          initialValue: topicValue,
                          tooltip: 'Topic',
                          onSelected: (String value) {
                            setState(() {
                              topicValue = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuItem<String>>[
                              PopupMenuItem<String>(
                                onTap: () {
                                  conversationProvider.isRolePlay = true;
                                  Provider.of<ChatMessageProvider>(context,
                                          listen: false)
                                      .resetMessage();
                                },
                                value: "Roleplay",
                                child: const Text('Roleplay'),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
                                  conversationProvider.isParagraph = true;
                                  Provider.of<ChatMessageProvider>(context,
                                          listen: false)
                                      .resetMessage();
                                },
                                value: "Paragraph",
                                child: const Text('Paragraph'),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {
                                  conversationProvider.isFree = true;
                                  Provider.of<ChatMessageProvider>(context,
                                          listen: false)
                                      .resetMessage();
                                },
                                value: "Free",
                                child: const Text('Free'),
                              ),
                            ];
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Text(
                              topicValue ?? "Topic",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 14.w),
                          child: Countdown(
                            controller: _countdownController,
                            seconds: 48000,
                            build: (BuildContext context, double time) {
                              return Text(formatDuration(time));
                            },
                            interval: const Duration(seconds: 1),
                            onFinished: () {},
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              const ChatWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
