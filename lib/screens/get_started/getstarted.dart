import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SPEAK UP!",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "Practice English Effectively",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: appHeight(context) * 0.6,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            crossAxisCount: 2),
                    // padding: EdgeInsets.symmetric(vertical: 10.h),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            "images/womanpurple.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            "images/mangreen.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            "images/manpurple.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            "images/manyellow.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => SignUpScreen(),
                    // ));
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
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: const Color.fromRGBO(104, 73, 255, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .popAndPushNamed(AppRouteConstants.loginRouteName);
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: const Color.fromRGBO(104, 73, 255, 1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            )),
      ),
    );
  }
}
