import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/sign_in/forgotpassword.dart';
import 'package:megabite/widget/custom_input.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isHidden = true;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();
  FToast fToast;
  final auth = FirebaseAuth.instance;
  final List<String> errors = [];
  bool _loginFormLoading = false;
  String _loginEmail = "";
  String _loginPassword = "";
  FocusNode _passwordFocusNode;
  User user;

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

  Future<void> _alertToastBuilder(String error) async {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox( child: Icon( Icons.error, color: Colors.white, size: 28, ),),
            SizedBox( width: 12.0, ),
            SizedBox(child: Text(error, style: TextStyle(color: Colors.white, fontSize: 16),),
            width: 240.0,),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 4),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    if (user.emailVerified) {
      //automatically redirect to Mainscreen
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      setState(() {
        _loginFormLoading = false;
        Fluttertoast.showToast(
          msg: "Kindly verify your mail first!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          //timeInSecForIosWeb: 5,
          backgroundColor: Color.fromRGBO(0, 205, 134, 1.0),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }

  //login account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _loginEmail, password: _loginPassword)
          .then((value) {
            checkEmailVerified();
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Wrong Email or Password!';
      } else if (e.code == 'user-not-found') {
        return 'Oops! User not found!';
      } else if (e.code == 'user-diabled') {
        return 'This Account has been disabled!';
      } else if (e.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        return 'Check your internet connection!';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _loginFormLoading = true;
    });
    String _loginAccountFeedack = await _loginAccount();
    if (_loginAccountFeedack != null) {
      _alertToastBuilder(_loginAccountFeedack);
      setState(() {
        _loginFormLoading = false;
      });
    } /*else {
      Navigator.pop(context);
      //
    }*/
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: devHeight * 0.025,
            ),
            //Mail TextField
            CustomInput(
              hintText: "Enter your mail",
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _loginEmail = value;
                /*
                setState(() {
                  _loginEmail = value.trim();
                });
                */
                if (value.isNotEmpty) {
                  removeError(error: Constants.kEmailNullError);
                } else if (Constants.emailValidatorRegExp.hasMatch(value)) {
                  removeError(error: Constants.kInvalidEmailError);
                }
                return null;
              },
              onSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: Constants.kEmailNullError);
                  return Constants.kEmailNullError;
                } else if (!Constants.emailValidatorRegExp.hasMatch(value)) {
                  addError(error: Constants.kInvalidEmailError);
                  return Constants.kInvalidEmailError;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
            //.........................
            SizedBox(
              height: devHeight * 0.045,
            ),
            //Password Textfield
            CustomInput(
              obscureText: _isHidden,
              hintText: "Enter your password",
              labelText: "Password",
              onChanged: (value) {
                _loginPassword = value;
                /*
                setState(() {
                  _loginPassword = value.trim();
                });
                */
                if (value.isNotEmpty) {
                  removeError(error: Constants.kPassNullError);
                } else if (value.length >= 8) {
                  removeError(error: Constants.kShortPassError);
                }
                return null;
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: Constants.kPassNullError);
                  return Constants.kPassNullError;
                } else if (value.length < 8) {
                  addError(error: Constants.kShortPassError);
                  return Constants.kShortPassError;
                }
                return null;
              },
              focusNode: _passwordFocusNode,
              onSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.done,
              prefixIcon: Icon(Icons.lock_outline_rounded),
              suffixIcon: InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            //........................
            SizedBox(
              height: devHeight * 0.045,
            ),
            Row(
              children: [
                /*Checkbox(
                  value: remember,
                  activeColor: Color(0xff00c569),
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),*/
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                      remember = !remember;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      decoration: BoxDecoration(
                        color: remember ? Color(0xFF00c569) : Colors.transparent,
                        borderRadius: BorderRadius.circular(5.0),
                        border: remember ? null : Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        )
                      ),
                      width: 21,
                      height: 21,
                      child: remember ? Icon( Icons.check_rounded, color: Colors.white, size: 18,) : null,
                    ),
                  ),
                ),
                Text("Remember me", style: TextStyle(fontFamily: 'VarelaRound'),),
                Spacer(),
                TextButton(
                    child: Text("Forgot Password?", style: TextStyle(fontFamily: 'VarelaRound'),),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ForgotPass()));
                    }),
              ],
            ),
            SizedBox(
              height: devHeight * 0.045,
            ),
            //Continue Button
            Container(
              width: double.infinity,
              child: Bouncing(
                onPress: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // if all are valid then go to successive screen
                    //Navigator.pushNamed(context, null);
                    _submitForm();
                  }
                },
                child: DefaultButton(
                  isLoading: _loginFormLoading,
                  text: "Login",
                ),
              ),
            ),
            //...................
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
