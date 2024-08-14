import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:megabite/mainscreen.dart';
import 'package:megabite/onboarding/welcomescreen.dart';
import 'package:megabite/screens/home/homepage.dart';

import 'package:provider/provider.dart';
//import 'package:megabite/provider/themeprovider.dart';
//import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Phoenix(child: MyApp()));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //User user;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: "Megabite",
          debugShowCheckedModeBanner: false,
          //themeMode: themeProvider.themeMode,
          theme: ThemeData(
                    textTheme: GoogleFonts.varelaRoundTextTheme(
                      Theme.of(context).textTheme,
                    ),
          ),
          home: FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.redAccent),
                              Text( "Error!", style: TextStyle( fontSize: 28, color: Colors.redAccent, fontFamily: 'VarelaRound'),)
                            ],
                          ),
                          Text( "${snapshot.error}", style: TextStyle( fontSize: 16, fontFamily: 'VarelaRound'), ),
                        ],
                      )
                    );
                  }

                if (snapshot.connectionState == ConnectionState.done) {
                  return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, streamSnapshot) {
                      if (streamSnapshot.hasError) {
                        return Scaffold(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, color: Colors.redAccent),
                                    Text( "Error!", style: TextStyle( fontSize: 28, color: Colors.redAccent, fontFamily: 'VarelaRound'),)
                                  ],
                                ),
                              Text( "${streamSnapshot.error}", style: TextStyle( fontSize: 16, fontFamily: 'VarelaRound'), ),
                            ],
                          ));
                      }

                      if (streamSnapshot.connectionState ==
                          ConnectionState.active) {
                        User _user = streamSnapshot.data;
                        if (_user == null) {
                          return WelcomeScreen();
                        } else {
                          if (_user.emailVerified) {
                            return HomePage();
                          } else {
                            return WelcomeScreen();
                          }
                        }
                      }

                      return LoadingScreen();
                    },
                  );
                }

                return LoadingScreen();
              }),
          //routes: routes,
        );
    
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00c569)),
            ),
      )
    );
  }
}
