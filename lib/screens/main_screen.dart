/*import 'package:flutter/material.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
      title: "Megabite",
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: HomePage(),
    );
    },
  );
}*/