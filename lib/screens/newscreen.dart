/*import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:megabite/onboarding/welcomescreen.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:megabite/screens/mainscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(Phoenix(child: MyApp()));
  /*SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
  );*/
  /*SystemChrome.setEnabledSystemUIOverlays(
    [ ]
  );*/
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
  User user;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: "Megabite",
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            accentColor: Colors.white,
            dividerColor: Colors.black,
            scaffoldBackgroundColor: Color(0xffffffff),
            bottomAppBarColor: Colors.white,
            shadowColor: Colors.black54,
            cardColor: Color(0xffefefef),
            //colorScheme: ColorScheme.light(),
            //primarySwatch: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.varelaRoundTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          darkTheme: ThemeData(
            accentColor: Colors.black,
            dividerColor: Colors.white,
            scaffoldBackgroundColor: Color(0xFF141414),
            bottomAppBarColor: Color(0xFF303030),
            shadowColor: Colors.white54,
            cardColor: Color(0xff303030),
            colorScheme: ColorScheme.dark(),
          ),
          home: FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, streamSnapshot) {
                      if (streamSnapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error: ${streamSnapshot.error}"),
                          ),
                        );
                      }

                      if (streamSnapshot.connectionState ==
                          ConnectionState.active) {
                        User _user = streamSnapshot.data;
                        if (_user == null) {
                          return WelcomeScreen();
                        } else {
                          if (_user.emailVerified) {
                            return MainScreen();
                          } else {
                            return WelcomeScreen();
                          }
                        }
                      }

                      return Scaffold(
                        //Checking Authentication
                        body: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/load.json'),
                      )
                ),
                      );
                    },
                  );
                }

                return Scaffold(
                  //Intializing App
                  body: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      width: 300,
                      child: Lottie.asset('assets/load.json'),
                      )
                ),
                );
              }),
          //routes: routes,
        );
      });
}
*/