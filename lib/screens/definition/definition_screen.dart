import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefinitionScreen extends StatelessWidget {
  const DefinitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: AppBar(
          title: const Text(
            'Definitions',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Row(
              children: [
                IconButton.filled(
                  onPressed: () {},
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
                  "parental",
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
                    "relating to or characteristic of or befitting a \nparent",
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
                    "Parental guidance is essential for child's development \n\nMy parents have always been very supportive and have shown me a great deal of parental guidance supportive and have shown me a great deal of parental guidance",
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
