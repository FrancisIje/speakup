import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speakup/screens/signup/language.dart';
import 'package:speakup/services/auth/auth_service.dart';

import 'package:speakup/utils/app_route_const.dart';
import 'package:speakup/utils/responsive.dart';

String? picUrl;

class ProfilePicScreen extends StatefulWidget {
  const ProfilePicScreen({super.key});

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  io.File? _image;
  late XFile? pickedImage;

  bool obsureText = true;
  void navToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouteConstants.homeRouteName, (route) => false);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _image = io.File(pickedImage!.path);
        });
      }
    } catch (e) {
      print("ImagePicker error: $e");
    }
  }

  Future<void> uploadFile(XFile? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );
    }

    UploadTask uploadTask;

    try {
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("users")
          .child(AuthService.firebase().currentUser!.id);

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file!.path},
      );

      uploadTask = ref.putFile(io.File(file.path), metadata);
      await Future.value(uploadTask);

      picUrl = await ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ADD YOUR PROFILE \nPICTURE!",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Center(
                      child: _image == null
                          ? Icon(
                              Icons.account_circle_outlined,
                              size: 250.h,
                            )
                          : CircleAvatar(
                              radius: 125.r,
                              backgroundImage: FileImage(_image!),
                            ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                    right: Radius.circular(40)))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload from files",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Icon(
                            Icons.image_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                    right: Radius.circular(40)))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Take a picture",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: appHeight(context) * 0.18,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_image != null) {
                          try {
                            await uploadFile(pickedImage);
                            // Navigator.pushNamed(context,
                            //     AppRouteConstants.verifybuilderRouteName);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LanguageScreen(),
                            ));
                          } catch (e) {
                            SnackBar(content: Text("Error, try again"));
                          }
                        } else {
                          SnackBar(content: Text("Input an image"));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(104, 73, 255, 1)),
                        fixedSize: MaterialStatePropertyAll(
                            Size(double.maxFinite, 50.h)),
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
                      height: 14.h,
                    ),
                    Align(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
