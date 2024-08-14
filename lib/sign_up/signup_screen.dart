import 'package:flutter/material.dart';
import 'package:megabite/buttons/action_text.dart';
import 'package:megabite/buttons/google_button.dart';
import 'package:megabite/phone_sign/phonescreen.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/sign_in/signin_screen.dart';
import 'package:megabite/sign_up/signup_form.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            CustomAppBar(
              appbarcolor: Color(0xffffffff),
              leftimage: Image(
                image: AssetImage("assets/icon/icon_dark/arrow_back.png"),
              ),
              lefttap: () {
                Navigator.pop(context);
              },
              leftcolor: Color(0xffffffff),
              text: "Sign Up",
              rightimage: Image.asset("assets/images/blank.png"),
              righttap: () {},
              rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: Container(
                color: Color(0xffffffff),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: devHeight * 0.03,
                        ),
                        Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: devHeight * 0.055,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'VarelaRound'),
                        ),
                        Text(
                          "Complete your details!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: devHeight * 0.025, fontFamily: 'VarelaRound'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.055 * devWidth, vertical: 0.030 * devWidth),
                          child: Container(
                            child: SignupForm(),
                          ),
                        ),
                        Text(
                            " ― or ― ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: devHeight * 0.024,
                                fontFamily: 'VarelaRound'),
                          ),
                          SizedBox(height: devHeight * 0.016),
                          Center(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 0.055 * devWidth),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GoogleButton(),
                                  //SizedBox(width: devWidth * 0.042),
                                  Text("|",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: devHeight * 0.028,
                                fontFamily: 'VarelaRound'),
                          ),
                                  //Phone Button
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(1),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 0.0800 * devWidth, vertical: 0.0400 * devWidth)),
                                      backgroundColor: MaterialStateProperty.all(
                                        Color(0xffffffff),
                                      ), // <-- Button color
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color>((states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors
                                              .grey[200]; // <-- Splash color
                                        }
                                        return null;
                                      }),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PhoneScreen()));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.02 * devWidth),
                                          child: Image(
                                            image: AssetImage("assets/icon/icon_dark/phone.png"),
                                            width: 0.06 * devWidth,
                                          ),
                                        ),
                                        Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontSize: 0.048 * devWidth,
                                            fontFamily: 'VarelaRound',
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //..........................................
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: devHeight * 0.025),
                          Container(
                            child: ActionText(
                              text: "Already have an account? ",
                              height: 0.022 * devHeight,
                              text2: "Sign In",
                              text2color: Color(0xFF00C569),
                              height2: 0.022 * devHeight,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                              },
                            ),
                          ),
                        /*Text(
                          " ― or ― ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'VarelaRound'
                          ),
                        ),
                        Container(
                          height: 0.075 * devHeight,
                          child: ActionText(
                            text: "Already have an account? ",
                            height: 0.022 * devHeight,
                            text2: "Sign In",
                            text2color: Color(0xFF00C569),
                            height2: 0.022 * devHeight,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: devHeight * 0.01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "By continuing, you confirm that you agree",
                                style: TextStyle(
                                  fontSize: 0.020 * devHeight,
                                  fontFamily: 'VarelaRound'
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "with our ",
                              style: TextStyle(
                                fontSize: 0.020 * devHeight,
                                fontFamily: 'VarelaRound'
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "T&C",
                                style: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 0.020 * devHeight,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'VarelaRound'
                                ),
                              ),
                            ),
                            Text(
                              " and ",
                              style: TextStyle(
                                fontSize: 0.020 * devHeight,
                                fontFamily: 'VarelaRound'
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Private Policy",
                                style: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 0.020 * devHeight,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'VarelaRound'
                                ),
                              ),
                            ),
                          ],
                        ),*/
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
