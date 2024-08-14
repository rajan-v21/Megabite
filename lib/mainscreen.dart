/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megabite/onboarding/welcomescreen.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return WelcomeScreen();
    } else {
      if (user.emailVerified) {
        return HomePage();
      } else {
        return WelcomeScreen();
      }
    }
  }
}*/