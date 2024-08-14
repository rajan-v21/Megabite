import 'package:flutter/material.dart';

class NotiContent extends StatefulWidget {

  @override
  _NotiContentState createState() => _NotiContentState();
}

class _NotiContentState extends State<NotiContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Center(child: Text("Noti Content"),)      
    );
  }
}