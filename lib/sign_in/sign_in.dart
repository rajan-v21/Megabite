import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:megabite/onboarding/walkthrough.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/screens/main_screen.dart';
import 'package:megabite/sign_in/passreset.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password;
  User user;
  FToast fToast;
  final auth = FirebaseAuth.instance;
  final List<String> errors = [];
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //......................................................................

  @override
void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
}

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
            //height: 40.0,
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

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email, password: _password).then((value) {

//...........................................................................................
                    FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text("Error: ${snapshot.error}"),),);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(body: Center(child: Text("Error: ${streamSnapshot.error}"),),);
                }

                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User _user = streamSnapshot.data;
                    if (_user.emailVerified){
                      return HomePage();
                      }
                    else{
                      return WalkThrough();
                    }
                  }

                return Scaffold(
                  //Checking Authentication
                  body: Container(
                      alignment: Alignment.center,
                      child: Lottie.asset('assets/load.json'),
                      ),
                );
              },
            );
          }

          return Scaffold(
            //Intializing App
            body: Container(
                alignment: Alignment.center,
                child: Lottie.asset('assets/load.json'),
                ),
          );
        }
        );
//...........................................................................................

                    }
                    );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Wrong Email or Password!';
      } else if (e.code == 'user-not-found') {
        return 'Oops! User not found!';
      } else if (e.code == 'user-diabled') {
        return 'This Account has been disabled!';
      } else if (e.message == 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
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
    }else {
      Navigator.pop(context);
    }
  }


  //.......................................................................
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),),
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
                child: Text('Sign In'),
                onPressed: (){
                    _submitForm();
                    //Navigator.pop(context);
                  
                }
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("Forgot Password?"),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassReset()));
                } 
              )
            ],
          )
        ],
      ),      
    );
  }
}