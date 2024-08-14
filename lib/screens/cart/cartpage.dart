import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/screens/cart/cartcontent.dart';
import 'package:megabite/screens/favorite/favoritepage.dart';
import 'package:megabite/widget/custom_appbar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int itemCount = 0;

  CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');
  User _user = FirebaseAuth.instance.currentUser;

  /*@override
  void initState() {
    _userRef.doc(_user.uid).collection("Cart").get().then((value) {
      setState(() {
        itemCount = value.docs.length;
      });
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
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
            text: "Cart",
            rightimage: Image(
              image: AssetImage("assets/icon/icon_dark/favorite.png"),
            ),
            righttap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoritePage()));
            },
            rightcolor: Color(0xffffffff),
          ),

          StreamBuilder(
            stream: _userRef.doc(_user.uid).collection("Cart").snapshots(),
            builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.active){
                              //List _documents = snapshot.data.docs;
                              itemCount = snapshot.data.docs.length;
                              /*_userRef.doc(_user.uid).collection("Cart").doc(snapshot.data.docs.id).get().then((value) {
                                setState(() {
                                  _selectedCategories = "${itemCat[i]}";
                                  itemCal = value.data()['calories'][_selected].toString();
                                  itemPrice =value.data()['sprice'][_selected].toString();
                                });
                                    });*/
                              //for (int i = 0; i <= itemCount; i++){}
                              //_userRef.doc(_user.uid).collection("Cart").get();
                            }
            return (itemCount != 0) ? Expanded(
              child: Stack(children: [
                CartContent(),
                DraggableScrollableSheet(
                  initialChildSize: 0.26,
                  minChildSize: 0.26,
                  maxChildSize: 0.39,
                  builder:
                      (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                          width: devWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Have a promocode?",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Apply Here",
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[900],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sub-Total",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "₹" + "1881.00",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shipping",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "+ ₹" + "50.00",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    indent: 24,
                                    endIndent: 24,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(
                                    height: 90,
                                  )
                                ],
                              ),
                            ),
                          ])
                          //height: 300,
                          //color: Colors.yellow,
                          ),
                    );
                  },
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Amount:",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Text("₹" + "1996.00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Bouncing(
                            onPress: () {},
                            child: DefaultButton(
                              text: "Checkout",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ) : Center(child: Image(image: AssetImage("assets/images/empty_cart.png"), height: devHeight * 0.75, width: devWidth * 0.75));
            }
          ),
                  ],
      ),
    );
  }
}
