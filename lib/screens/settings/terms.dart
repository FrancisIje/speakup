import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool readToc = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'TERMS & CONDITIONS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accept the terms to continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              // height: appHeight(context) * 0.4,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'These terms and conditions outline the rules and regulations for the use of SpeakUp\'s Website, located at SpeakUp. By accessing this website we assume you accept these terms and conditions.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Do not continue to use SpeakUp if you do not agree to take all of the terms and conditions stated on this page.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: \'Client\', \'You\' and \'Your\' refers to you, the person log on this website and compliant to the Company\'s terms and conditions. \'The Company\', \'Ourselves\', \'We\', \'Our\' and \'Us\'. refers to our Company. \'Party\', \'Parties\', or \'Us\', refers to both the Client and ourselves.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client\'s needs in respect of provision of the Company\'s stated services, in accordance with and subject to, prevailing law of us.',
                      style: TextStyle(fontSize: 14.h),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Any use of the above terminology or other words in the singular, plural, capitalization and/or he/',
                      style: TextStyle(fontSize: 14.h),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Checkbox(
                  value: readToc,
                  activeColor: Colors.black54,
                  overlayColor: const MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.black54,
                  onChanged: (value) {
                    setState(() {
                      readToc = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(),
                ),
                Text(
                  'I have read and accept the terms and conditions',
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
