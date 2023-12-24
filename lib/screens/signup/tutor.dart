import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/models/user.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/screens/home/conversation.dart';
import 'package:speakup/screens/signup/native_language.dart'
    show selectedNativeLanguage;
import 'package:speakup/screens/signup/target_language.dart'
    show selectedTargetLanguage, selectedLangLevel;
import 'package:speakup/screens/signup/names.dart'
    show
        emailTextController,
        lastNameTextController,
        firstNameTextController,
        phoneNumTextController;
import 'package:speakup/screens/signup/pfp.dart' show picUrl;
import 'package:speakup/services/cloud/firebase_cloud.dart';

import 'package:speakup/utils/responsive.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  @override
  Widget build(BuildContext context) {
    String? selectedTutor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CHOOSE YOUR TUTOR",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "Kindly choose your preferred tutor to \ncontinue",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  // controller: emailTextController,
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xFF777777)),
                      hintText: "Search",
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.r)))),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          child: SizedBox(
                              height: appHeight(context) * 0.25,
                              width: appWidth(context) * 0.46,
                              child: Image.asset(
                                'images/manpurple.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: appWidth(context) * 0.46,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              hint: const Text('Choose voice'),
                              value: selectedTutor,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTutor = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            16.r))), // Add outlined border
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                              items: <String>[
                                'Voice 1',
                                'Voice 2',
                                'Voice 3',
                                'Voice 4'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          child: SizedBox(
                            height: appHeight(context) * 0.25,
                            width: appWidth(context) * 0.46,
                            child: Image.asset(
                              'images/womanpurple.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Visibility(
                          child: Text(
                            "Female",
                            style: TextStyle(color: Colors.black),
                          ),
                          visible: selectedTutor == "Female",
                        ),
                        SizedBox(
                          width: appWidth(context) * 0.46,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              hint: const Text('Choose voice'),
                              value: selectedTutor,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTutor = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            16.r))), // Add outlined border
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                              items: <String>[
                                'Voice 5',
                                'Voice 5',
                                'Voice 7',
                                'Voice 8'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () async {
                    print("buttom");
                    try {
                      print("tapped");
                      SpeakupUser user = SpeakupUser(
                          firstName: firstNameTextController.text,
                          lastName: lastNameTextController.text,
                          email: emailTextController.text,
                          phoneNumber: phoneNumTextController.text,
                          targetLanguage: selectedTargetLanguage ?? "",
                          targetLangLevel: selectedLangLevel ?? "",
                          nativeLanguage: selectedNativeLanguage ?? " ",
                          profilePictureUrl: picUrl ?? "",
                          tutorGender: selectedTutor ?? "");
                      await FirebaseCloud()
                          .updateUserData(user.toSpeakupUserMap());
                      SpeakupUser? firebaseUser =
                          await FirebaseCloud().getCurrentUser();
                      print(firebaseUser?.profilePictureUrl ??
                          "no firebaseUser img");
                      if (firebaseUser != null) {
                        Provider.of<UserInfoProvider>(context, listen: false)
                            .setUser(user);
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ConversationScreen(),
                      ));
                    } catch (e) {
                      print(e);
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
