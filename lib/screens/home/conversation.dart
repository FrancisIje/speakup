import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/is_talking.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/screens/home/widget/chat.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late FlutterGifController controller;
  // late FlutterGifController controller2;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();

    controller = FlutterGifController(vsync: this);
    // controller2 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(
        min: 0,
        max: 10,
        period: const Duration(milliseconds: 2000),
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is disposed
    emailTextController.dispose();
    passwordTextController.dispose();
    // controller.dispose();
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
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userSpeakUpInfo!.firstName),
              accountEmail: Text(userSpeakUpInfo.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(userSpeakUpInfo.firstName[0]),
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
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E3FF),
        title: Text(
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
              onPressed: () {}, icon: const Icon(Icons.closed_caption_off)),
          IconButton(onPressed: () {}, icon: Icon(Icons.download_rounded)),
        ],
        titleTextStyle: TextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black),
        shape: Border(bottom: BorderSide(color: Colors.black26)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Consumer<Talking>(
              builder: (context, value, child) {
                return value.isTalking
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        child: Container(
                          height: appHeight(context) * 0.34,
                          width: appWidth(context),
                          child: GifImage(
                            fit: BoxFit.fill,
                            controller: controller,
                            image: AssetImage("gif/woman-talking.gif"),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        child: Container(
                          height: appHeight(context) * 0.34,
                          width: appWidth(context),
                          child: GifImage(
                            controller: controller,
                            // controller: controller2,
                            fit: BoxFit.fill,
                            image: const AssetImage(
                              "gif/woman-listening.gif",
                            ),
                          ),
                        ),
                      );
              },
            ),
            ChatWidget(),
          ],
        ),
      ),
    );
  }
}
