import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/services/auth.dart';
import 'package:megabite/provider/constants.dart';
import 'package:provider/provider.dart';

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Container(
      child: _isSigningIn
          ? Padding(
            padding: EdgeInsets.only(left: 0.12 * devWidth),
            child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Constants.kPrimaryColor),
                ),
          )
          : OutlinedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 0.0800 * devWidth, vertical: 0.0400 * devWidth)),
                backgroundColor:
                    MaterialStateProperty.all(Color(0xffffffff),), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey[200]; // <-- Splash color
                  }
                  return null;
                }),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User user =
                    await Authentication.signInWithGoogle(context: Phoenix.rebirth(context));

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  //Navigator.pop(context);
                }
              },
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 0.02 * devWidth),
                      child: Image(
                        image: AssetImage("assets/icon/google_logo.png"),
                        width: 0.06 * devWidth,
                      ),
                    ),
                    Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 0.048 * devWidth,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'VarelaRound'
                        ),
                      ),
                  ],
              ),
            ),
      );
  }
}
