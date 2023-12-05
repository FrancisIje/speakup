import 'package:flutter/material.dart';

import 'package:speakup/screens/signup/passwords.dart';
import 'package:speakup/screens/signup/verify.dart';

class VerifyBuilder extends StatefulWidget {
  const VerifyBuilder({super.key});

  @override
  State<VerifyBuilder> createState() => _VerifyBuilderState();
}

class _VerifyBuilderState extends State<VerifyBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const VerifyEmailScreen();

          case ConnectionState.active:
          case ConnectionState.done:
            return const PasswordSetScreen();
        }
      },
    );
  }
}
