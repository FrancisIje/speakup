import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/user_provider.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'PERSONAL DETAILS',
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
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('Name'),
            trailing: InkWell(
              onTap: () {},
              child: const Text(
                "Change",
                style: TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
              ),
            ),
          ),
          ListTile(
            trailing: InkWell(
              onTap: () {},
              child: const Text(
                "Change",
                style: TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
              ),
            ),
            leading: const Icon(Icons.call),
            title: const Text('Phone Number'),
          ),
          ListTile(
            trailing: InkWell(
              onTap: () {},
              child: const Text(
                "Change",
                style: TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
              ),
            ),
            leading: const Icon(Icons.mail),
            title: const Text('Email Address'),
          ),
          ListTile(
            trailing: InkWell(
              onTap: () {},
              child: const Text(
                "Change",
                style: TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
              ),
            ),
            leading: const Icon(Icons.blur_circular_rounded),
            title: const Text('Native Language'),
          ),

          ListTile(
            trailing: InkWell(
              onTap: () {},
              child: const Text(
                "Change",
                style: TextStyle(color: Color.fromRGBO(104, 73, 255, 1)),
              ),
            ),
            leading: const Icon(Icons.blur_circular_rounded),
            title: const Text('Target Language'),
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
                "Social Handles",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
