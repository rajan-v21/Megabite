import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megabite/buttons/action_text.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/sign_up/signup_screen.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:megabite/widget/custom_input.dart';
import 'package:provider/provider.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final auth = FirebaseAuth.instance;
  String _email = "";

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

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
                        image: AssetImage("assets/icon/icon_dark/arrow_back.png"),),
                lefttap: () {
                  Navigator.pop(context);
                },
                leftcolor: Color(0xffffffff),
                text: "Forgot Password",
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
                          height: devHeight * 0.09,
                        ),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: devHeight * 0.055,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'VarelaRound'),
                        ),
                        Text(
                          "Enter your Email and we will send you",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: devHeight * 0.025, fontFamily: 'VarelaRound'),
                        ),
                        Text(
                          "a link to return to your account!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: devHeight * 0.025, fontFamily: 'VarelaRound'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.055 * devWidth),
                          child: Container(
                            child: Form(
                                key: _formKey,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: devHeight * 0.040,
                                      ),
                                      //Mail TextField
                                      CustomInput(
                                        hintText: "Enter your mail",
                                        labelText: "Email",
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (value) {
                                          _email = value;
                                          if (value.isNotEmpty) {
                                            removeError(
                                                error: Constants.kEmailNullError);
                                          } else if (Constants.emailValidatorRegExp
                                              .hasMatch(value)) {
                                            removeError(
                                                error:
                                                    Constants.kInvalidEmailError);
                                          }
                                          return null;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            addError(
                                                error: Constants.kEmailNullError);
                                            return Constants.kEmailNullError;
                                          } else if (!Constants.emailValidatorRegExp
                                              .hasMatch(value)) {
                                            addError(
                                                error:
                                                    Constants.kInvalidEmailError);
                                            return Constants.kInvalidEmailError;
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.done,
                                        prefixIcon:
                                            Icon(Icons.mail_outline_rounded),
                                      ),
                                      //.........................
                                      SizedBox(
                                        height: devHeight * 0.050,
                                      ),
                                      //Continue Button
                                      Container(
                                        child: Bouncing(
                                          onPress: () {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();
                                              // if all are valid then go to successive screen
                                              //_submitForm();
                                              auth
                                                  .sendPasswordResetEmail(
                                                      email: _email)
                                                  .then((value) async {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Please follow the link sent on your mail to reset password!",
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  //timeInSecForIosWeb: 5,
                                                  backgroundColor: Color.fromRGBO(
                                                      0, 205, 134, 1.0),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              });
                                            }
                                          },
                                          child: DefaultButton(
                                            text: "Continue",
                                          ),
                                        ),
                                      ),
                                      //...................
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Text(
                          "― or ―",
                          style: TextStyle(color: Colors.black54,
                              fontFamily: 'VarelaRound'),
                        ),
                        Container(
                          height: 0.1 * devHeight,
                          child: ActionText(
                            text: "Don't have an account? ",
                            height: 0.022 * devHeight,
                            text2: "Sign Up",
                            text2color: Color(0xFF00C569),
                            height2: 0.022 * devHeight,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: devHeight * 0.035,
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
