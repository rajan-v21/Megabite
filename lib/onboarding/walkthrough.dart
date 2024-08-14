import 'package:flutter/material.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:megabite/buttons/action_text.dart';
import 'package:megabite/buttons/google_button.dart';
import 'package:megabite/phone_sign/phone.dart';
import 'package:megabite/sign_in/signin_screen.dart';
import 'package:megabite/sign_up/signup_screen.dart';

class WalkThrough extends StatefulWidget {

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Center(
          child: 
          Container(
            height: 250,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Create Account'),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }
                ),
              Text(
                "― or ―",
                style: TextStyle(color: Colors.black38),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GoogleButton(),
                  Bouncing(
                    onPress: () {}, 
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey[200], // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Phone()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: 24, 
                              height: 24, 
                              child: Image(
                                image: AssetImage("assets/icon/phone_icon.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ActionText(
                text: "Already have an account? ",
                height: 0.02 * devHeight,
                text2: "Sign in",
                text2color: Color(0xFF00C569),
                height2: 0.02 * devHeight,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                  },
                ),
              ],
            ),
          ),
        ),    
    );
  }
}