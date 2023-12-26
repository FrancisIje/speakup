import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:speakup/provider/user_provider.dart';

class SpeechControllerPage extends StatelessWidget {
  const SpeechControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final speechFormKey = GlobalKey<FormState>();
    // final userDetails = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'SPEECH CONTROLLER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: speechFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text("Kindly customize tutor’s speech rate here!"),
              SizedBox(
                height: 34.h,
              ),
              Text("Speech Rate"),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                validator: (value) {
                  return "Enter between 40 and 100";
                },
                decoration: InputDecoration(
                  errorStyle:
                      const TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter between 40 and 100",
                  hintStyle:
                      TextStyle(color: Colors.grey[600], fontSize: 12.sp),
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
              Expanded(child: SizedBox()),
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
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
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
    );
  }
}
