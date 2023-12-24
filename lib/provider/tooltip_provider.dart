import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/text_word_switch.dart';
import 'package:speakup/screens/home/widget/custom_bubble.dart';

class TooltipProvider with ChangeNotifier {
  OverlayEntry? _currentTooltipOverlay;
  bool _isTooltipVisible = false;

  OverlayEntry? get currentTooltipOverlay => _currentTooltipOverlay;
  bool get isTooltipVisible => _isTooltipVisible;

  void showTooltip(BuildContext context, String word, TapDownDetails details) {
    if (!_isTooltipVisible) {
      _currentTooltipOverlay = OverlayEntry(
        builder: (context) => Positioned(
          top: details.globalPosition.dy - 100.h,
          left: details.globalPosition.dx - 50,
          child: Material(
            color: Colors.transparent,
            child: CustomPaint(
              painter: customStyleArrow(),
              child: Container(
                width: 140.w,
                color: Color.fromRGBO(59, 55, 79, 1),
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
                                  .toggleSelection();
                            },
                            child: Consumer<TextWordProvider>(
                              builder: (context, textWordProvider, child) =>
                                  textWordProvider.isText
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          color: Colors.white,
                                          child: const Text(
                                            "Text",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          color: null,
                                          child: const Text(
                                            "Text",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                            )),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              Provider.of<TextWordProvider>(context,
                                      listen: false)
                                  .toggleSelection();
                            },
                            child: Consumer<TextWordProvider>(
                              builder: (context, textWordProvider, child) =>
                                  !textWordProvider.isText
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          color: Colors.white,
                                          child: Text(
                                            "Word",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          color: null,
                                          child: Text(
                                            "Word",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text("$word",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold)),
                  ],
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
