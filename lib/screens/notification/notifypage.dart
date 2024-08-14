import 'package:flutter/material.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/notification/noticontent.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class NotifyPage extends StatefulWidget {

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              CustomAppBar(
              appbarcolor: Color(0xffffffff),
              leftimage: Image(
                image: AssetImage("assets/icon/icon_dark/arrow_back.png"),
              ),
              lefttap: () {
                Navigator.pop(context);
              },
              leftcolor: Color(0xffffffff),
              text: "Notifications",
              rightimage: Image.asset("assets/images/blank.png"),
              righttap: () {},
              rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: NotiContent(),
            )
            ],
          ),
        )),
    );
  }
}