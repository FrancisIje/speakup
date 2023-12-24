import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/models/user.dart';
import 'package:speakup/provider/chat_message.dart';
import 'package:speakup/provider/conversation_state_provider.dart';
import 'package:speakup/provider/is_chat_hidden.dart';
import 'package:speakup/provider/is_talking.dart';
import 'package:speakup/provider/user_provider.dart';

import 'package:speakup/screens/home/widget/chat.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';
import 'package:speakup/screens/home/widget/pdf_generator.dart';
import 'package:speakup/screens/home/widget/video_player.dart';
import 'package:speakup/screens/settings/settings.dart';
import 'package:speakup/services/cloud/firebase_cloud.dart';
import 'package:speakup/services/gpt/gpt.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

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

  Future<void> getUser() async {
    SpeakupUser? user = await FirebaseCloud().getCurrentUser();
    print(user?.profilePictureUrl ?? "no user img");
    if (user != null) {
      Provider.of<UserInfoProvider>(context, listen: false).setUser(user);
    }
  }

  void handleSubmitted(
      {required String text,
      required bool isRolePlay,
      required bool isParagraph,
      required bool isFree}) async {
    print("submitted");

    ChatMessage message = ChatMessage(
      text: text,
      role: "user",
    );
    Provider.of<ChatMessageProvider>(context, listen: false)
        .insertMessage(message);

    String response;
    print("tapped");
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

      print(response);
      ChatMessage reply = ChatMessage(
        text: response,
        role: "assistant",
      );
      Provider.of<ChatMessageProvider>(context, listen: false)
          .insertMessage(reply);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _chatGPTApi = ChatGPTApi(context);
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();

    _fadeInController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _fadeOutController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
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
    final userSpeakUpInfo = Provider.of<UserInfoProvider>(context).user;
    final conversationProvider =
        Provider.of<ConversationStateProvider>(context, listen: false);
    var msgToSave = Provider.of<ChatMessageProvider>(context).messages;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userSpeakUpInfo?.firstName ?? ""),
              accountEmail: Text(userSpeakUpInfo?.email ?? ""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(userSpeakUpInfo?.firstName[0] ?? ""),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Glossary',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Conversation',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Definition',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(
                    context, AppRouteConstants.definitionScreenRouteName);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'VocTest',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
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
            fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black),
        shape: const Border(bottom: BorderSide(color: Colors.black26)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: Duration(seconds: 5),
              transitionBuilder: (Widget child, Animation<double> animation) {
                const begin = Offset(1.0, 0.0);
                const end = Offset(0.0, 0.0);
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: Curves.easeInOut));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: Consumer<Talking>(
                builder: (context, value, child) {
                  return value.isTalking
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          child: SizedBox(
                            width: appWidth(context),
                            key: ValueKey("speaking_woman_key"),
                            child: VideoWidget(
                              videoPath: "videos/speaking_woman.mp4",
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              child: SizedBox(
                                width: appWidth(context),
                                key: ValueKey("listening_woman_key"),
                                child: VideoWidget(
                                  videoPath: "videos/listening_woman.mp4",
                                ),
                              ),
                            ),
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
                                        Provider.of<ChatMessageProvider>(
                                                context,
                                                listen: false)
                                            .resetMessage();
                                      },
                                      value: "Roleplay",
                                      child: Text('Roleplay'),
                                    ),
                                    PopupMenuItem<String>(
                                      onTap: () {
                                        conversationProvider.isParagraph = true;
                                        Provider.of<ChatMessageProvider>(
                                                context,
                                                listen: false)
                                            .resetMessage();
                                      },
                                      value: "Paragraph",
                                      child: Text('Paragraph'),
                                    ),
                                    PopupMenuItem<String>(
                                      onTap: () {
                                        conversationProvider.isFree = true;
                                        Provider.of<ChatMessageProvider>(
                                                context,
                                                listen: false)
                                            .resetMessage();
                                      },
                                      value: "Free",
                                      child: Text('Free'),
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
                          ],
                        );
                },
              ),
            ),
            const ChatWidget(),
          ],
        ),
      ),
    );
  }
}
