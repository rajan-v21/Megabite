import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class OtpVerify extends StatefulWidget {
  final String phone;
  OtpVerify(this.phone);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  String _verificationCode;
  FToast fToast;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              //Phoenix.rebirth(context);
              return HomePage();
            }
          });
          return null;
        },
        verificationFailed: (FirebaseException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(211, 211, 211, 1),
      //fromRGBO(126, 203, 224, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(43, 46, 66, 1),
      ),
    );
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              text: "Verify OTP",
              rightimage: Image.asset("assets/images/blank.png"),
              righttap: () {},
              rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: Container(
                color: Color(0xffffffff),
                width: double.infinity,
                //margin: EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.1 * devHeight,
                        ),
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontSize: devHeight * 0.055,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'VarelaRound'),
                        ),
                        Text(
                          "An OTP has been sent to",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: devHeight * 0.027,
                          fontFamily: 'VarelaRound'),
                        ),
                        Text(
                          "+91 ${widget.phone}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: devHeight * 0.030,
                          fontFamily: 'VarelaRound'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: devWidth * 0.1,
                              vertical: devHeight * 0.1),
                          child: PinPut(
                            fieldsCount: 6,
                            keyboardType: TextInputType.phone,
                            //withCursor: true,
                            textStyle: const TextStyle(
                                fontSize: 25.0, color: Colors.black),
                            eachFieldWidth: 40.0,
                            eachFieldHeight: 55.0,
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            submittedFieldDecoration: pinPutDecoration,
                            followingFieldDecoration: pinPutDecoration,
                            pinAnimationType: PinAnimationType.fade,
                            selectedFieldDecoration: pinPutDecoration.copyWith(
                              color: Color(0xffffffff),
                              border: Border.all(
                                width: 2,
                                color: const Color(0xFF00c569),
                              ),
                            ),
                            onSubmit: (pin) async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationCode,
                                            smsCode: pin))
                                    .then((value) async {
                                  if (value.user != null) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                    //return HomePage();
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                //........................................................
                                Widget toast = Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.redAccent,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          "Inavlid OTP!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'VarelaRound'),
                                        ),
                                        width: 240.0,
                                      ),
                                    ],
                                  ),
                                );
                                fToast.showToast(
                                  child: toast,
                                  gravity: ToastGravity.TOP,
                                  toastDuration: Duration(seconds: 4),
                                );
                                //........................................................
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 0.05 * devHeight,
                        ),
                        buildTimer(),
                        SizedBox(
                          height: 0.01 * devHeight,
                        ),
                        //..........................
                        OutlinedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(1),
                            shape: MaterialStateProperty.all(
                              CircleBorder(),
                            ),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(12)),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xffffffff),
                            ), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey[200]; // <-- Splash color
                              }
                              return null;
                            }),
                          ),
                          onPressed: () {},
                          child: Image(
                            image: AssetImage("assets/icon/icon_dark/reload.png"),
                            height: 0.034 * devHeight,
                          ),
                        ),
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

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Re-send OTP in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Color(0xff00c569)),
          ),
        ),
      ],
    );
  }
}
