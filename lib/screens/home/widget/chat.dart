import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:speakup/models/user.dart';
import 'package:speakup/provider/chat_message.dart';
import 'package:speakup/provider/conversation_state_provider.dart';
import 'package:speakup/provider/is_chat_hidden.dart';
import 'package:speakup/provider/tooltip_provider.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/provider/words_to_voc.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';
import 'package:speakup/services/cloud/firebase_cloud.dart';

import 'package:speakup/services/gpt/gpt.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  String statusText = "";
  bool isComplete = false;
  String recordFilePath = "";
  int i = 0;
  bool isRecording = false;
  bool isRecorderReady = false;
  String? path;
  final TextEditingController _messagesController = TextEditingController();

  late final ChatGPTApi _chatGPTApi;

  String formatTime(int seconds) {
    // Format seconds into HH:MM:SS.mmm
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime =
        '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}.000';
    return formattedTime;
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  // Future record() async {
  // if (!isRecorderReady) return;
  // await recorder.startRecorder(toFile: 'audio');
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isRecording = true;
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      isRecording = false;
      setState(() {});
    }
  }

  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _chatGPTApi = ChatGPTApi(context);
    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final wordsList = Provider.of<WordsProvider>(
      context,
    ).wordsToAddList;

    final userSpeakUpInfo = Provider.of<UserInfoProvider>(context).user;
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

      try {
        if (isRolePlay) {
          response = await ChatGPTApi(context).startRolePlay(
              text,
              userSpeakUpInfo?.targetLanguage ?? "English",
              userSpeakUpInfo?.targetLangLevel ?? "A1");
        } else if (isParagraph) {
          response = await ChatGPTApi(context).startParagraph(
              text,
              userSpeakUpInfo?.targetLanguage ?? "English",
              userSpeakUpInfo?.targetLangLevel ?? "A1");
        } else if (isFree) {
          response = await _chatGPTApi.getChatCompletion(
            question: text,
            learnLang: userSpeakUpInfo?.targetLanguage ?? "English",
          );
        } else {
          response = await _chatGPTApi.getChatCompletion(
            question: text,
            learnLang: userSpeakUpInfo?.targetLanguage ?? "English",
          );
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

    final conversationState = Provider.of<ConversationStateProvider>(context);
    if (Provider.of<ChatMessageProvider>(context, listen: true)
        .messages
        .isEmpty) {
      handleSubmitted(
          text: "Let's start",
          isRolePlay: conversationState.isRolePlay,
          isParagraph: conversationState.isParagraph,
          isFree: conversationState.isFree);
    }
    final conversationSate = Provider.of<ConversationStateProvider>(context);
    return Expanded(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    Provider.of<TooltipProvider>(context,
                                            listen: false)
                                        .hideTooltip(context);
                                    isRecording = true;
                                  });
                                  startRecord();
                                },
                                child: const Icon(Icons.mic_none)),
                          ),
                          Container(
                            width: 250.w,
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            height: 60.h,
                            child: TextField(
                              onTap: () {
                                Provider.of<TooltipProvider>(context,
                                        listen: false)
                                    .hideTooltip(context);
                              },
                              controller: _messagesController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Say something ...",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF777777)),
                                  contentPadding: EdgeInsets.only(left: 10.w)),
                            ),
                          ),
                        ],
                      )),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () async {
                      if (_messagesController.text.isNotEmpty) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                        // _sendMessage(_messagesController.text);
                        handleSubmitted(
                            text: _messagesController.text,
                            isFree: conversationSate.isFree,
                            isParagraph: conversationSate.isParagraph,
                            isRolePlay: conversationSate.isRolePlay);
                        _messagesController.clear();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      child: Container(
                        height: 60.h,
                        width: 48.w,
                        color: Colors.white,
                        child: const Center(
                          child: Icon(Icons.send_outlined,
                              color: Color(0xFF555555)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isRecording
                  ? GestureDetector(
                      onTap: () async {
                        stopRecord();

                        File audioFile = File(recordFilePath);

                        String? transcribedText = await ChatGPTApi(context)
                            .transcribeAudio(audioFile.path);

                        transcribedText == null
                            ? const SnackBar(
                                content: Text("Record audio again"))
                            : handleSubmitted(
                                text: transcribedText,
                                isFree: conversationSate.isFree,
                                isParagraph: conversationSate.isParagraph,
                                isRolePlay: conversationSate.isRolePlay);
                      },
                      child: Container(
                        height: 40.h,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stop),
                            Text("Tap to stop recording")
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () async {
            if (Provider.of<TooltipProvider>(context, listen: false)
                    .isTooltipVisible ==
                true) {
              Provider.of<TooltipProvider>(context, listen: false)
                  .hideTooltip(context);
              if (wordsList.isNotEmpty && wordsList.length > 1) {
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
                        vocWords: null)
                    .toSpeakupUserMap();

                await FirebaseCloud().updateUserData(userUpdate);
              }
            }
          },
          onPanDown: (details) async {
            if (Provider.of<TooltipProvider>(context, listen: false)
                    .isTooltipVisible ==
                true) {
              Provider.of<TooltipProvider>(context, listen: false)
                  .hideTooltip(context);
              if (wordsList.isNotEmpty && wordsList.length > 1) {
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
                        vocWords: null)
                    .toSpeakupUserMap();

                await FirebaseCloud().updateUserData(userUpdate);
              }
            }
          },
          onPanUpdate: (details) async {
            if (Provider.of<TooltipProvider>(context, listen: false)
                    .isTooltipVisible ==
                true) {
              Provider.of<TooltipProvider>(context, listen: false)
                  .hideTooltip(context);
              if (wordsList.isNotEmpty && wordsList.length > 1) {
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
                        vocWords: null)
                    .toSpeakupUserMap();

                await FirebaseCloud().updateUserData(userUpdate);
              }
            }
          },
          child: Visibility(
            visible: Provider.of<IsChatVisibleProvider>(context).isChatVisible,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Consumer<ChatMessageProvider>(
                  builder: (ctx, value, child) => Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemBuilder: (_, int index) => value.messages[index],
                          itemCount: value.messages.length,
                        ),
                      ),
                      const Divider(height: 1.0),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
