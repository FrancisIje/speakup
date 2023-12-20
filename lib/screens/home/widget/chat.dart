import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
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
  String statusText = "";
  bool isComplete = false;
  String recordFilePath = "";
  int i = 0;
  bool isRecording = false;
  bool isRecorderReady = false;
  String? path;
  final TextEditingController _messagesController = TextEditingController();

  List<ChatMessage> _messages = [];
  late final ChatGPTApi _chatGPTApi;

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

  // Future stop() async {

  // }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   if (status != PermissionStatus.granted) {
  //     throw "Microphone permission not granted";
  //   }
  //   await recorder.openRecorder();
  //   isRecorderReady = true;
  // }

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

  void _handleSubmitted(String text) async {
    print("submitted");
    _messagesController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      role: "user",
    );
    setState(() {
      _messages.insert(0, message);
    });
    print("tapped");
    try {
      String response = await _chatGPTApi.getChatCompletion(text);
      print(response);
      ChatMessage reply = ChatMessage(
        text: response,
        role: "assistant",
      );
      setState(() {
        _messages.insert(0, reply);
      });
    } catch (e) {
      print("Error: $e");
    }
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
                        _handleSubmitted(
                          _messagesController.text,
                        );
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
                            : _handleSubmitted(transcribedText);
                      },
                      child: Container(
                        height: 40.h,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: Row(
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
