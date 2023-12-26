import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/utils/responsive.dart';
// import 'package:provider/provider.dart';
// import 'package:speakup/provider/user_provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final speechFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final userDetails = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'SEND REVIEW',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                    "We would love to hear your feedback, if you’re \ninterested in sending us a review."),
                SizedBox(
                  height: 34.h,
                ),
                SizedBox(
                  height: appHeight(context) * 0.35,
                  child: TextFormField(
                    scrollPhysics: BouncingScrollPhysics(),
                    key: speechFormKey,
                    expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter at least 2 characters";
                      }
                      return null;
                    },
                    minLines: null,
                    maxLines: null,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      errorStyle: const TextStyle(
                          color: Color.fromRGBO(104, 73, 255, 1)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Comment...",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 12.sp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.r),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.r),
                          ),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: appHeight(context) * 0.2,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (speechFormKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(104, 73, 255, 1)),
                    fixedSize:
                        MaterialStatePropertyAll(Size(double.maxFinite, 50.h)),
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(40),
                                right: Radius.circular(40)))),
                  ),
                  child: Text(
                    "Save Data",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
