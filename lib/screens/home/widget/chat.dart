import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:speakup/provider/chat_message.dart';
import 'package:speakup/provider/conversation_state_provider.dart';
import 'package:speakup/provider/tooltip_provider.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/provider/vtt_filepath.dart';
// import 'package:record/record.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';

import 'package:speakup/services/gpt/gpt.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  // final ScrollController scrollController = ScrollController();
  // final record = AudioRecorder();
  // final recorder = FlutterSoundRecorder();

  // late ConversationStateProvider conversationState;
  String statusText = "";
  bool isComplete = false;
  String recordFilePath = "";
  int i = 0;
  bool isRecording = false;
  bool isRecorderReady = false;
  String? path;
  final TextEditingController _messagesController = TextEditingController();

  late final ChatGPTApi _chatGPTApi;

  Future<String> generateAndSaveVttFile(
      String text, BuildContext context) async {
    String vttContent = await generateVttContent(text);

    // Specify the file path
    String fileName = 'subtitles.vtt';

    // Get the documents directory using path_provider package
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/$fileName';

    // Create the directories if they don't exist
    if (!await Directory('${documentsDirectory.path}/path/to/your/file/')
        .exists()) {
      await Directory('${documentsDirectory.path}/path/to/your/file/')
          .create(recursive: true);
    }

    // Save the VTT content to a file
    File file = File(filePath);
    file.writeAsStringSync(vttContent);

    print('VTT content has been saved to $filePath');
    Provider.of<VttFilePathProvider>(context, listen: false)
        .setFilePath(filePath);
    return filePath;
  }

  Future<String> generateVttContent(String text) async {
    StringBuffer vttContent = StringBuffer();

    // Add the VTT header
    vttContent.writeln("WEBVTT");
    vttContent.writeln();

    // Split the text into lines and generate VTT cues
    List<String> lines = text.split('\n');
    int cueIndex = 1;
    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        // Generate VTT cue
        vttContent.writeln("$cueIndex");
        vttContent.writeln(formatTime(0) +
            " --> " +
            formatTime(5)); // Replace with the desired time range
        vttContent.writeln(line);
        vttContent.writeln();

        cueIndex++;
      }
    }

    return vttContent.toString();
  }

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

  @override
  void initState() {
    // TODO: implement initState
    _chatGPTApi = ChatGPTApi(context);

    // initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // recorder.closeRecorder();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

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
      // setState(() {
      //   _messages.insert(0, message);
      // });
      print("tapped");
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
        // generateAndSaveVttFile(response, context);

        print(response);
        ChatMessage reply = ChatMessage(
          text: response,
          role: "assistant",
        );
        Provider.of<ChatMessageProvider>(context, listen: false)
            .insertMessage(reply);
        // setState(() {
        //   _messages.insert(0, reply);
        // });
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
          padding: const EdgeInsets.all(8.0),
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
                                  // if (await record.hasPermission()) {
                                  //   // Start recording to file
                                  //   await record.start(const RecordConfig(),
                                  //       path: 'aFullPath/myFile.m4a');
                                  //   // ... or to stream
                                  //   final stream = await record.startStream(
                                  //       const RecordConfig(
                                  //           encoder: AudioEncoder.pcm16bits));
                                  // }

                                  // Stop recording...

                                  // record.dispose();
                                },
                                child: Icon(Icons.mic_none)),
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
                              cursorColor: Colors.white,
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
                        //! path = await record.stop();

                        // path = await recorder.stopRecorder();
                        // File audioFile = File(path!);
                        // print(path);
                        // setState(() {
                        //   isRecording = false;
                        // });

                        stopRecord();

                        // print(recordFilePath.);
                        File audioFile = File(recordFilePath);

                        String? transcribedText = await ChatGPTApi(context)
                            .transcribeAudio(audioFile.path);
                        // .sendAudioToOpenAI(audioFile);
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
          onTap: () {
            Provider.of<TooltipProvider>(context, listen: false)
                .hideTooltip(context);
          },
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
                    Divider(height: 1.0),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
