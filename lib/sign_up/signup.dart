import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megabite/screens/home/homecontent.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/screens/main_screen.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  FToast fToast;
  final auth = FirebaseAuth.instance;
  final List<String> errors = [];
  User user;
  Timer timer;
  
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //............................................................................
  
  Future<void> _alertToastBuilder(String error) async {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
            SizedBox(child: Icon(Icons.error, color: Colors.white, size: 32,),
            ),
            SizedBox(
            width: 12.0,
            ),
            SizedBox(child: Text(error, style: TextStyle(color: Colors.white),),
            width: 220.0,
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
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Phoenix.rebirth(context);
      return HomePage();
    }
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email, password: _password).then((value) async {
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
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
  });
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak!';
      } else if (e.code == 'email-already-in-use') {
        return 'An account for this Email already exists. Sign-Up with another mail!';
      } else if (e.code == 'user-diabled') {
        return 'This account is disabled!';
      }else if (e.message == 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        return 'Check your internet connection!';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    String _signInFeedack = await _loginAccount();
    if (_signInFeedack != null) {
      _alertToastBuilder(_signInFeedack);
    }/*else {
      Navigator.pop(context);
    }*/
  }

  //............................................................................
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              onChanged: (value){
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              onChanged: (value){
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Back'),
                onPressed: (){
                  Navigator.pop(context);
                }
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Sign Up'),
                onPressed: (){
                  _submitForm();
                  //Navigator.pop(context);
                }
              ),
            ],
          )
        ],
      ),      
    );
  }
}