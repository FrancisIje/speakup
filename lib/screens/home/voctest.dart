import "package:flutter/material.dart";
import "package:speakup/services/d_id/d_idservice.dart";

class VocText extends StatelessWidget {
  const VocText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Text('VocTest'),
          centerTitle: true,
          backgroundColor: Colors.blue,
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
