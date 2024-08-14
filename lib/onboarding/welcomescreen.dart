import 'dart:async';

import 'package:flutter/material.dart';
import 'package:megabite/buttons/action_text.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/buttons/google_button.dart';
import 'package:megabite/onboarding/splash_content.dart';
import 'package:megabite/phone_sign/phonescreen.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/sign_in/signin_screen.dart';
import 'package:megabite/sign_up/signup_screen.dart';
import 'package:provider/provider.dart';



/*
CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Constants.kPrimaryColor),
            )
            */

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": 'Get Started',
      "description": 'Only 3 Simple Steps!',
      "image": 'assets/images/steps.png',
    },
    {
      "text": 'One-Tap Order',
      "description":
          'Choose among Large Categories of Delicious Food with just One Tap',
      "image": 'assets/images/browse.png',
    },
    {
      "text": 'Secure Payment',
      "description": 'Secure Online Payment and Cash on Delivery Option',
      "image": 'assets/images/securepayment.png',
    },
    {
      "text": 'Quick Service',
      "description":
          'Fastest Delivery Service so You can Enjoy Your Food Quickly',
      "image": 'assets/images/quickservice.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffffffff),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]['text'],
                    image: splashData[index]['image'],
                    subline: splashData[index]['description'],
                  ),
                ),
              ),
              SizedBox(height: devHeight * 0.025),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      SizedBox(height: devHeight * 0.015),
                      //Sign in Button
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: devHeight * 0.01, horizontal: 0.1 * devWidth),
                            child: Bouncing(
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: DefaultButton(
                                text: "Create Account",
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: devHeight * 0.01, horizontal: 0.1 * devWidth),
                            child: Bouncing(
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffb3ffdb),
                                  borderRadius: BorderRadius.circular(15),
                                ),
          child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: devHeight * 0.025),
                    child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 0.048 * devWidth,
                            color: Color(0xff00C569),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'VarelaRound'),
                      ),
                  ),
                  
                ),
        ),
    )
                            ),
                            SizedBox(
                          height: devHeight * 0.01,
                        ),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "By continuing, you agree with our",
                                style: TextStyle(
                                  fontSize: 0.020 * devHeight,
                                  fontFamily: 'VarelaRound'
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /*Text(
                              "with our ",
                              style: TextStyle(
                                fontSize: 0.020 * devHeight,
                                fontFamily: 'VarelaRound'
                              ),
                            ),*/
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "T&C",
                                style: TextStyle(
                                  color: Color(0xff00C569),
                                  fontSize: 0.020 * devHeight,
                                  //decoration: TextDecoration.underline,
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
                                  color: Color(0xff00C569),
                                  fontSize: 0.020 * devHeight,
                                  //decoration: TextDecoration.underline,
                                  fontFamily: 'VarelaRound'
                                ),
                              ),
                            ),])
                          //),
                          /*Text(
                            " ― or ― ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: devHeight * 0.024,
                                fontFamily: 'VarelaRound'),
                          ),
                          SizedBox(height: devHeight * 0.009),
                          Center(
                            child: Container(
                              width: double.infinity,
                              padding:
                                EdgeInsets.symmetric(horizontal: 0.1 * devWidth),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GoogleButton(),
                                  //SizedBox(width: devWidth * 0.042),
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
                                          EdgeInsets.symmetric(horizontal: 0.0635 * devWidth, vertical: 0.0335 * devWidth)),
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
                          ),*/
                        ],
                      ),
                      //SizedBox(height: devHeight * 0.025),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Constants.kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: currentPage == index ? 8 : 6,
      width: currentPage == index ? 8 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Color(0xff00c569)
            : Constants.kSecondaryColorLight,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
