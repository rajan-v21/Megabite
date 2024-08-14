import 'package:flutter/material.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/home/homecontent.dart';
import 'package:megabite/screens/profile/profilecontent.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              CustomAppBar(
              appbarcolor: Color(0xffffffff),
              leftimage: Image(
                image: AssetImage("assets/icon/icon_dark/arrow_back.png")
              ),
              lefttap: () {
                Navigator.pop(context);
              },
              leftcolor: Color(0xffffffff),
              text: "Profile",
              rightimage: Image.asset("assets/images/blank.png"),
              righttap: () {},
              rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: ProfileContent(),
            )
            ],
          ),
        )
    );
  }
}