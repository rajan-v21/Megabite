import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FToast ftoast;

  static get fToast => FToast();

  static Future<User> signInWithGoogle({@required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.message == 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
          //.............................................................
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
                SizedBox( child: Text( 'Check your internet connection!', style: TextStyle(color: Colors.white, fontSize: 16),), width: 240.0,),
              ],
            ),
          );
          fToast.showToast(
            child: toast,
            gravity: ToastGravity.TOP,
            toastDuration: Duration(seconds: 4),
          );
          //.................................................................
          
        }
      } catch (e) {
        Authentication.fToast(
          
        );
        //.............................................................
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
                SizedBox( child: Text( 'Error occurred using Google Sign-In. Try again!', style: TextStyle(color: Colors.white, fontSize: 16),), width: 240.0,),
              ],
            ),
          );
          fToast.showToast(
            child: toast,
            gravity: ToastGravity.TOP,
            toastDuration: Duration(seconds: 4),
          );
          //.................................................................
      }
    }

    return user;
  }
}
