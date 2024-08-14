import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/widget/custom_input.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  FToast fToast;
  final auth = FirebaseAuth.instance;
  final List<String> errors = [];
  bool _registerFormLoading = false;
  String _registerEmail = "";
  String _registerPassword = "";
  String userName = "";
  FocusNode _passwordFocusNode;
  User user;
  CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  User _user = FirebaseAuth.instance.currentUser;

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
              error,
              style: TextStyle(color: Colors.white, fontSize: 16),
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
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    if (user.emailVerified) {
      //Phoenix.rebirth(context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  //Create new account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _registerEmail, password: _registerPassword)
          .then((value) async {
        Fluttertoast.showToast(
          msg: "Follow the link on your mail and verify!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          //timeInSecForIosWeb: 5,
          backgroundColor: Color.fromRGBO(0, 205, 134, 1.0),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        user = auth.currentUser;
        user.sendEmailVerification();
        checkEmailVerified();
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak!';
      } else if (e.code == 'email-already-in-use') {
        return 'An account for this Email already exists!';
      } else if (e.code == 'user-diabled') {
        return 'This account has been disabled!';
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
      _registerFormLoading = true;
    });
    String _createAccountFeedack = await _createAccount();
    if (_createAccountFeedack != null) {
      _alertToastBuilder(_createAccountFeedack);
      setState(() {
        _registerFormLoading = false;
      });
    }
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
    //timer.cancel();
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
            //Name TextField
            CustomInput(
              hintText: "Enter your name",
              labelText: "Name",
              keyboardType: TextInputType.name,
              onChanged: (value) {
                userName = value;
                FirebaseFirestore.instance.collection('Users').doc(_user.uid).set({
                  'name' : userName
                });
                /*
                setState(() {
                  _registerEmail = value.trim();
                });
                */
                if (value.isNotEmpty) {
                  removeError(error: Constants.kNamelNullError);
                }
                return null;
              },
              onSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: Constants.kNamelNullError);
                  return Constants.kNamelNullError;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            //.........................
            SizedBox(
              height: devHeight * 0.045,
            ),
            //.................................................
            //Mail TextField
            CustomInput(
              hintText: "Enter your mail",
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _registerEmail = value;
                /*
                setState(() {
                  _registerEmail = value.trim();
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
                _registerPassword = value;
                /*
                setState(() {
                  _registerPassword = value.trim();
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
            //Continue Button
            Container(
              width: double.infinity,
              child: Bouncing(
                onPress: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // if all are valid then go to success screen
                    //Navigator.pushNamed(context, null);
                    _submitForm();
                  }
                },
                child: DefaultButton(
                  isLoading: _registerFormLoading,
                  text: "Register",
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
