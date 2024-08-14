/*import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {

  static final lightTheme = ThemeData(
    //scaffoldBackgroundColor: Color(0xFFF0F0F0),
    accentColor: Colors.white,
    dividerColor: Colors.black,
    scaffoldBackgroundColor: Color(0xffffffff),
    bottomAppBarColor: Colors.white,
    shadowColor: Color(0xFF7c7b7e),
    cardColor: Color(0xffefefef),
    colorScheme: ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    accentColor: Colors.black,
    dividerColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFF141414),
    bottomAppBarColor: Color(0xFF303030),
    shadowColor: Colors.white54,
    cardColor: Color(0xff303030),
    colorScheme: ColorScheme.dark(),
  );
  
}
*/