import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/screens/get_started/getstarted.dart';
import 'package:speakup/services/auth/auth_service.dart';
import 'package:speakup/services/cloud/firebase_cloud.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

late TextEditingController verifyPasswordController;
final _deleteKey = GlobalKey<FormState>();

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    verifyPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'DELETE ACCOUNT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            const Text("Are you sure you want to delete your account?"),
            SizedBox(
              height: 14.h,
            ),
            const Text(
                "If yes, tap Proceed button. Note, any remaining \nsubscription amount will be lost"),
            SizedBox(
              height: 25.h,
            ),
            const Text("Verify Password"),
            SizedBox(
              height: 10.h,
            ),
            Form(
              key: _deleteKey,
              child: TextFormField(
                controller: verifyPasswordController,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password is greater than 6 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter password",
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
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () async {
                if (_deleteKey.currentState!.validate()) {
                  await AuthService.firebase().logIn(
                      email: userDetails.user!.email,
                      password: verifyPasswordController.text);
                  await FirebaseCloud().deleteUserData();
                  await AuthService.firebase()
                      .deleteAccount()
                      .then((value) =>
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .setUser(null))
                      .then((value) => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const GetStartedScreen(),
                          )));
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
                "Proceed",
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
    );
  }
}
