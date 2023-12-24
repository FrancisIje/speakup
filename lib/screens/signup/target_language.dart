import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakup/screens/signup/native_language.dart';

class TargetLanguageScreen extends StatefulWidget {
  const TargetLanguageScreen({super.key});

  @override
  State<TargetLanguageScreen> createState() => _TargetLanguageScreenState();
}

String? selectedTargetLanguage;
String? selectedLangLevel;

class _TargetLanguageScreenState extends State<TargetLanguageScreen> {
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
                  "YOUR TARGET LANGUAGE",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "Which language do you plan to study",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 30.h,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: const Text('Choose language'),
                    value: selectedTargetLanguage,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTargetLanguage = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(16.r))), // Add outlined border
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                    items: <String>[
                      'English',
                      'Spanish',
                      'German',
                      'French',
                      'Arabic',
                      'Italian',
                      'Japanese',
                      'Mandarin',
                      'Urdu',
                      'Portuguese',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    hint: const Text('Choose proficiency level'),
                    value: selectedLangLevel,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLangLevel = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(16.r))), // Add outlined border
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                    items: <String>['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NativeLanguageScreen(),
                    ));
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
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
              ],
            )),
      ),
    );
  }
}
