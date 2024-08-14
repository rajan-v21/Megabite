import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassReset extends StatefulWidget {

  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset'),),
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
                child: Text('Reset'),
                onPressed: (){
                  auth.sendPasswordResetEmail(email: _email);
                  Fluttertoast.showToast(
                    msg: "Please follow the link sent on your mail to reset password.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    //timeInSecForIosWeb: 5,
                    backgroundColor: Color.fromRGBO(0, 205, 134, 1.0),
                    textColor: Colors.white,
                    fontSize: 16.0
                    );
                  //Navigator.of(context).pop();
                }
              ),
            ],
          ),
        ],
      ),      
    );
  }
}