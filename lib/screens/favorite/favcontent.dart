import 'package:flutter/material.dart';

class FavContent extends StatefulWidget {

  @override
  _FavContentState createState() => _FavContentState();
}

class _FavContentState extends State<FavContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Center(child: Text("Fav Content"),)      
    );
  }
}