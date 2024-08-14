import 'package:flutter/material.dart';
import 'package:megabite/main.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/favorite/favoritepage.dart';
import 'package:megabite/screens/notification/notifypage.dart';
import 'package:megabite/screens/order/orderpage.dart';
import 'package:megabite/screens/profile/profilepage.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.0,
                  offset: Offset(0, 8),
                  blurRadius: 15.0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval( child: Material( color: Colors.white, child: InkWell( onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage()));
                        }, child: Padding( padding: const EdgeInsets.all(14.0),
                      child: Image(
                        image: AssetImage("assets/icon/icon_dark/order.png"),),),),),),
              //
              ClipOval( child: Material( color:  Colors.white, child: InkWell( onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritePage()));
                        }, child: Padding( padding: const EdgeInsets.all(14.0),
                      child: Image(
                        image: AssetImage("assets/icon/icon_dark/favorite.png"),),),),),),
              //
              ClipOval( child: Material( color:  Colors.white, child: InkWell( onTap: () {}, child: Padding( padding: const EdgeInsets.all(14.0),
                      child: Image.asset("assets/images/blank.png"),),),),),
              //
              ClipOval( child: Material( color:  Colors.white, child: InkWell( onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotifyPage()));
                        }, child: Padding( padding: const EdgeInsets.all(14.0),
                      child: Image(
                        image: AssetImage("assets/icon/icon_dark/notification.png"),),),),),),
              //
              ClipOval( child: Material( color:  Colors.white, child: InkWell( onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
              }, child: Padding( padding: const EdgeInsets.all(14.0),
                      child: Image(
                        image: AssetImage("assets/icon/icon_dark/profile.png"),),),),),),
            ],
          
        ));
  }
}
