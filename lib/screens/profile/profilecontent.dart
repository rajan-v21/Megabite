import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:megabite/onboarding/welcomescreen.dart';

class ProfileContent extends StatefulWidget {

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Center(
        child: MaterialButton(
          child: Text("LogOut",style: TextStyle( fontSize: 32, fontFamily: 'VarelaRound', fontWeight: FontWeight.w600),),
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
                   (Route<dynamic> route) => false
                  );
            //Phoenix.rebirth(context);
            //Navigator.of(context).pop();
          },
        )
      ),
    );
  }
}