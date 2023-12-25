import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/user_provider.dart';
import 'package:speakup/services/auth/auth_service.dart';
import 'package:speakup/utils/app_route_const.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SETTINGS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Row with CircleAvatar and Text for user's name
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  // Replace with your user's profile picture
                  backgroundImage:
                      NetworkImage(userDetails.user?.profilePictureUrl ?? ""),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userDetails.user!.firstName} ${userDetails.user!.lastName}",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Joined Sept. 13, 2013",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.5)),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),

          const Divider(),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                "Account",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.5)),
              ),
            ),
          ),

          // List of ListTile items
          ListTile(
            leading:
                const ImageIcon(AssetImage("images/personal_settings.png")),
            title: const Text('Personal Details'),
            onTap: () {
              Navigator.pushNamed(
                  context, AppRouteConstants.personalDetailsRouteName);
            },
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading:
                const ImageIcon(AssetImage("images/personal_settings.png")),
            title: const Text('Speech Controller'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRouteConstants.speechControllerRouteName);
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(
                AssetImage("images/speech_controller_icon.png")),
            title: const Text('Send Review'),
            onTap: () {
              // Handle onTap for Item 3
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/delete_icon.png")),
            title: const Text('Delete Account'),
            onTap: () {
              // Handle onTap for Item 4
            },
          ),
          const Divider(),
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                "Subscription",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.5)),
              ),
            ),
          ),

          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/unsubscribe_icon.png")),
            title: const Text('Subscription Plans'),
            onTap: () {
              // Handle onTap for Item 5
            },
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                "Contact & Information",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.5)),
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/support_icon.png")),
            title: const Text('Terms & Conditions'),
            onTap: () {
              // Handle onTap for Item 6
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/contact_us_icon.png")),
            title: const Text('Contact Us'),
            onTap: () {
              // Handle onTap for Item 7
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/faq_icon.png")),
            title: const Text('FAQ'),
            onTap: () {
              // Handle onTap for Item 8
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            leading: const ImageIcon(AssetImage("images/sign_out_icon.png")),
            title: const Text('Sign out'),
            onTap: () async {
              // Handle onTap for sign out
              await AuthService.firebase().logOut();
              Navigator.popAndPushNamed(
                  context, AppRouteConstants.loginRouteName);
            },
          ),
        ],
      ),
    );
  }
}
