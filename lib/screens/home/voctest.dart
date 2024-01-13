import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class VocTest extends StatelessWidget {
  const VocTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.h),
        child: AppBar(
          leading: const Icon(
            Icons.more_horiz_outlined,
            color: Colors.white,
          ),
          title: Text(
            'VocTest',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(104, 73, 255, 1),
          elevation: 0, // Optional: Remove the default shadow
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
