import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool firstTileSelected = true;
  bool secondTileSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Compare Our Subscription\nPlan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: const Text('Grow'),
              subtitle: const Text("Up to 3 months"),
              trailing: Checkbox(
                activeColor: Colors.black54,
                overlayColor: MaterialStatePropertyAll(Colors.white),
                checkColor: Colors.black54,
                value: firstTileSelected,
                onChanged: (value) {
                  setState(() {
                    firstTileSelected = value!;
                    if (value) {
                      secondTileSelected = false;
                    }
                  });
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: ListTile(
                // contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                // minVerticalPadding: 1,

                title: const Text('Enterprise'),
                subtitle: const Text("Up to 12 months"),
                trailing: Checkbox(
                  activeColor: Colors.black54,
                  overlayColor: MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.black54,
                  value: secondTileSelected,
                  onChanged: (value) {
                    setState(() {
                      secondTileSelected = value!;
                      if (value) {
                        firstTileSelected = false;
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          firstTileSelected
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      child: Text(
                        "Grow includes:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Unlimited Translations: Break down language barriers effortlessly with unlimited access to our cutting-edge translation services."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Interactive Tutoring: Dive into immersive language learning with our chat-based audio model. Personalized tutoring sessions to enhance your speaking and comprehension skills."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Priority Support: Enjoy top-notch customer support with priority assistance to ensure a smooth experience on your language journey."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Regular Updates: Stay ahead with the latest features and improvements as we continuously enhance your translation and tutoring experience."),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      child: Text(
                        "Enterprise includes:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Extended Access: Enjoy 12 months of uninterrupted language exploration, making this package perfect for long-term learners and enthusiasts."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Premium Tutoring: Elevate your language proficiency with extended and advanced chat-based audio tutoring. Dive into in-depth conversations and refine your skills."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Exclusive Features: Access additional languages, exclusive content, and advanced features reserved for our valued 1-year subscribers."),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          "Priority Everything: From customer support to new feature releases, experience the VIP treatment with priority access and assistance."),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
