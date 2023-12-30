import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/text_word_switch.dart';
import 'package:speakup/provider/words_to_voc.dart';
import 'package:speakup/screens/home/widget/custom_bubble.dart';
import 'package:speakup/services/gpt/gpt.dart';

class TooltipProvider with ChangeNotifier {
  OverlayEntry? _currentTooltipOverlay;
  bool _isTooltipVisible = false;

  OverlayEntry? get currentTooltipOverlay => _currentTooltipOverlay;
  bool get isTooltipVisible => _isTooltipVisible;

  void showTooltip(BuildContext context, String word, TapDownDetails details,
      String learnLang, String nativeLang) {
    if (!_isTooltipVisible) {
      _currentTooltipOverlay = OverlayEntry(
        builder: (context) => Positioned(
          top: details.globalPosition.dy - 100.h,
          left: details.globalPosition.dx - 60.w,
          // right: details.globalPosition.dx + 90.w,
          child: Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: CustomPaint(
                painter: customStyleArrow(),
                child: Container(
                  width: 160.w,
                  color: const Color.fromRGBO(59, 55, 79, 1),
                  padding: EdgeInsets.only(
                      left: 15.w, right: 15.w, bottom: 20.h, top: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Provider.of<TextWordProvider>(context,
                                        listen: false)
                                    .toggleSelection(isText: true);
                              },
                              child: Consumer<TextWordProvider>(
                                builder: (context, textWordProvider, child) =>
                                    textWordProvider.isText
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            color: Colors.white,
                                            child: const Text(
                                              "Word",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            color: null,
                                            child: const Text(
                                              "Word",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                              )),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                              onTap: () async {
                                Provider.of<TextWordProvider>(context,
                                        listen: false)
                                    .toggleSelection(isText: false);

                                Provider.of<WordsProvider>(context,
                                        listen: false)
                                    .addWord(word);
                              },
                              child: Consumer<TextWordProvider>(
                                builder: (context, textWordProvider, child) =>
                                    !textWordProvider.isText
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            color: Colors.white,
                                            child: const Text(
                                              "Translate",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            color: null,
                                            child: const Text(
                                              "Translate",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Consumer<TextWordProvider>(
                        builder: (context, textWordProvider, child) =>
                            !textWordProvider.isText
                                ? FutureBuilder(
                                    future: ChatGPTApi(context)
                                        .getWordTranslation(
                                            word: word,
                                            learnLang: learnLang,
                                            nativeLang: nativeLang),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Container();
                                        case ConnectionState.waiting:
                                          return const CupertinoActivityIndicator();
                                        case ConnectionState.active:
                                          return const CupertinoActivityIndicator();
                                        case ConnectionState.done:
                                          return Text(
                                            snapshot.data ?? "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                      }
                                    },
                                  )
                                : Text(
                                    word,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(_currentTooltipOverlay!);
      _isTooltipVisible = true;
      notifyListeners();
    }
  }

  void hideTooltip(BuildContext context) {
    if (_isTooltipVisible) {
      _currentTooltipOverlay?.remove();
      _currentTooltipOverlay = null;
      _isTooltipVisible = false;
      notifyListeners();
    }
  }
}
