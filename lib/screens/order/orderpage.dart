import 'package:flutter/material.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/cart/cartpage.dart';
import 'package:megabite/screens/order/ordercontent.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Column(
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
              text: "Orders",
              rightimage: Image(
                        image: AssetImage("assets/icon/icon_dark/cart.png"),
                      ),
                      righttap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                      },
                      rightcolor: Color(0xffffffff),
            ),
            Expanded(
              child: OrderContent(),
            )
            ],
          ),
    );
  }
}