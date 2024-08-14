import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/search.png")),
                Text("Search!", style: TextStyle(fontSize: devHeight * 0.05, fontFamily: 'VarelaRound', fontWeight: FontWeight.w900,),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}