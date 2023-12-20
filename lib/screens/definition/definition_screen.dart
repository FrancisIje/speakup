import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/services/gpt/gpt.dart';

class DefinitionScreen extends StatefulWidget {
  const DefinitionScreen({super.key});

  @override
  State<DefinitionScreen> createState() => _DefinitionScreenState();
}

class _DefinitionScreenState extends State<DefinitionScreen> {
  String? word;
  String? meaning;
  String? exampleSentence;

  String userLang = "English";
  @override
  void initState() {
    // TODO: implement initState
    getRandomWord();
    super.initState();
  }

  Future getRandomWord() async {
    var wordRes = await ChatGPTApi(context).generateWord(userLang);
    var meaningRes = await ChatGPTApi(context).getChatCompletion(
        "What is the meaning of $wordRes in 10 to 20 words in $userLang, use basic words such that non $userLang speakers can easily understand");
    var exampleRes = await ChatGPTApi(context).getChatCompletion(
        "Give 2 example sentences involving $wordRes in 10 to 15 words in $userLang, use basic words such that non $userLang speakers can easily understand");

    setState(() {
      word = wordRes;
      meaning = meaningRes;
      exampleSentence = exampleRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              )),
          title: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: const Text(
              'Definitions',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(104, 73, 255, 1),
          elevation: 0, // Optional: Remove the default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: Column(
          children: [
            Row(
              children: [
                IconButton.filled(
                  onPressed: () {
                    ChatGPTApi(context).fetchSpeech(word ?? "");
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  color: const Color.fromRGBO(104, 73, 255, 1),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  word ?? "",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: Container(
                width: double.maxFinite,
                height: 64.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.w, top: 14.h),
                  child: Text(
                    meaning ?? "",
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.65),
                        wordSpacing: 1.5,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Example sentences",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: Container(
                width: double.maxFinite,
                height: 170.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.w, top: 14.h),
                  child: Text(
                    exampleSentence ?? "",
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.65),
                        wordSpacing: 1.5,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
