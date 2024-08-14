import 'package:flutter/material.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/cart/cartpage.dart';
import 'package:megabite/screens/favorite/favcontent.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
              text: "Favorites",
              rightimage: Image(
                        image: AssetImage("assets/icon/icon_dark/cart.png"),
                      ),
                      righttap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                      },
                      rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: FavContent(),
            )
            ],
          ),
        )),
    );
  }
}