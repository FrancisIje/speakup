import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late TextEditingController faqSearchController;
  bool readToc = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqSearchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    faqSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FAQ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // validator: (value) {
              //   if (value == null) {
              //     return 'Enter password';
              //   } else {
              //     return null;
              //   }
              // },
              controller: faqSearchController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintStyle: const TextStyle(color: Color(0xFF777777)),
                  hintText: "Search",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(16.r)))),
            ),
            SizedBox(height: 20.h),
            Text(
              "Common questions",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.h),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                    "What sets SpeakUp English teaching app apart from others?")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text("What are the main features of the app?")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text("Can I track my progress using the app?")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                    "Are different levels of proficiency tests available?")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title:
                    Text("How can I improve my speaking skills with the app")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                horizontalTitleGap: 0,
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                    "Are there any grammar exercises or lessons in the app?")),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
