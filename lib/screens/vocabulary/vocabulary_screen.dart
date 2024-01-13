import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:speakup/utils/responsive.dart";

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late TextEditingController _vocSearchController;
  bool _hideWords = false;
  bool _hideTranslation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vocSearchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _vocSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.h),
        child: AppBar(
          leading: const Icon(
            Icons.more_horiz_outlined,
            color: Colors.white,
          ),

          title: DefaultTextStyle(
            style: TextStyle(
              fontSize: 34.sp,
              fontWeight: FontWeight.bold,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Vocabulary\n',
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  TextSpan(text: '(25 words)'),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90.h,
                    width: appWidth(context) * 0.65,
                    padding: EdgeInsets.only(bottom: 42.h),
                    child: TextField(
                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'Enter password';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: _vocSearchController,

                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Color(0xFF777777)),
                          hintText: "Search",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r)))),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 48.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16.r))),
                    child: Row(
                      children: [
                        Text("Exp"),
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(Icons.file_download_outlined)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          centerTitle: true,
          backgroundColor: const Color.fromRGBO(104, 73, 255, 1),
          elevation: 0, // Optional: Remove the default shadow
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: Container(
        height: appHeight(context) * 0.23,
        child: Stack(
          children: [
            Container(
              height: appHeight(context) * 0.2,
              child: null,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: appHeight(context) * 0.2,
                width: double.maxFinite,
                color: Color.fromARGB(255, 203, 193, 247),
                child: Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 36.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Switch(
                              value: _hideWords,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _hideWords = newValue;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.black,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor:
                                  const Color.fromRGBO(104, 73, 255, 1),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text("Hide words ")
                        ],
                      ),
                      Column(
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Switch(
                              value: _hideTranslation,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _hideTranslation = newValue;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.black,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor:
                                  const Color.fromRGBO(104, 73, 255, 1),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text("Hide translate ")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Color.fromRGBO(104, 73, 255, 1),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
