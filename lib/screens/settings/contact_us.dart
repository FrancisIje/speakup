import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool readToc = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'CONTACT US',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reach out to us via any of these means if you \nhave any complaints or suggestions',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
            const ListTile(
                leading: ImageIcon(AssetImage("images/twitter_icon.png")),
                title: Text("Twitter")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                leading: ImageIcon(AssetImage("images/linkedin_icon.png")),
                title: Text("LinkedIn")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                leading: ImageIcon(AssetImage("images/instagram_icon.png")),
                title: Text("Instagram")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                leading: ImageIcon(AssetImage("images/facebook_icon.png")),
                title: Text("Facebook")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                leading: ImageIcon(AssetImage("images/youtube_icon.png")),
                title: Text("Youtube")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
                leading: ImageIcon(AssetImage("images/whatsapp_icon.png")),
                title: Text("WhatsApp")),
            SizedBox(
              height: 10.h,
            ),
            const ListTile(
              leading: Icon(
                Icons.blur_circular_rounded,
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
              title: Text("Website"),
            ),
          ],
        ),
      ),
    );
  }
}
