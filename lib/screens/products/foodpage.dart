import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/buttons/search_button.dart';

class FoodPage extends StatefulWidget {
  final String foodId;
  FoodPage({this.foodId});
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with TickerProviderStateMixin<FoodPage> {

  AnimationController _hideFabAnimation;

  String itemName = '';
  String itemImage = '';
  String itemRate = '';
  String itemCal = '';
  String itemSeller = '';
  String itemPrice = '';
  String sellerImage = '';
  List itemAdd;
  List itemAddPrice;
  String _selectedCategories = '';
  String _selectedCalories = '';
  String _selectedPrice = '';
  bool _isChecked = false;
  int _selected = 0;
  int _itemCount = 1;
  List itemCat;
  bool _cartAdded = false;
  int _netPrice = 0;
  int _itemTAddPrice = 0;
  
  CollectionReference _foodRef =
      FirebaseFirestore.instance.collection('Food');

  CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  User _user = FirebaseAuth.instance.currentUser;

  Future _addToCart(){
    if(_isChecked == true)
      for(var j = 0; j < itemAdd.length; j++){
        _itemTAddPrice = _itemTAddPrice + itemAddPrice[j];
      }
    _netPrice = (int.parse(itemPrice) + _itemTAddPrice) * _itemCount;
    return _userRef
    .doc(_user.uid)
    .collection("Cart")
    .doc()
    .set({"categories" : _selectedCategories,
          "quantity" : _itemCount,
          "name": itemName,
          "image": itemImage,
          "itemPrice": int.parse(itemPrice),
          "totalprice": _netPrice,
          "netprice": _netPrice,
          if (_isChecked == true)
            "addon": itemAdd,
          if (_isChecked == true)
            "addprice": itemAddPrice
          else
            "addprice": null,}
    );
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product Added Succesfully!"),
  );

  @override
  void initState() {
    _foodRef.doc(widget.foodId).get().then((value) {
      setState(() {
        itemName = value.data()['name'];
        itemImage = value.data()['image'];
        itemRate = value.data()['rate'].toString();
        itemCal = value.data()['calories'][0].toString();
        itemAdd = value.data()['addon'];
        itemAddPrice = value.data()['aprice'];
        itemCat = value.data()['categories'];
        itemSeller = value.data()['seller'];
        itemPrice = value.data()['sprice'][0].toString();
        sellerImage = value.data()['simage'];
        _selectedCategories = itemCat[0];
        //_selectedCalories = itemCal[0];
        //_selectedPrice = itemPrice[0];
        
      });
    });
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
    super.initState();
    
  }
  
  @override
  void dispose(){
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Stack(
          children: [
            /*FadeInImage.assetNetwork(
                                        placeholder: "assets/images/no_img.jpg", 
                                        fadeOutDuration: Duration(seconds: 2),
                                        image: itemImage),*/
            CachedNetworkImage(
              imageUrl: itemImage,
              placeholder: (context, url) =>
                Image(image: AssetImage("assets/images/no_img.jpg"), fit: BoxFit.cover,),
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 1),
            ),
            ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(top: devHeight * 0.22),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: devHeight * 0.1),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF202020),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: devWidth * 0.75,
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                              child: Text(itemName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: Colors.white),),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 30.0),
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage("assets/images/stars.png")),
                                            Text(itemRate, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),),
                                            Text("(6)", style: TextStyle(fontSize: 12.0, color: Colors.white),)
                                          ],
                                        )),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange[400]),
                                        child: Text("🔥"+itemCal + " cals.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),)),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        ClipOval( child: Material( color: Color(0xFF303030), 
                                          child: InkWell( onTap: (){if(_itemCount>1){setState(()=>_itemCount--);}},
                                            child: Padding( padding: EdgeInsets.all(8.0), child: SizedBox( width: devHeight * 0.038, height: devHeight * 0.038,
                                                child: Icon(Icons.remove_rounded, color: Colors.white70,),
                                              ),
                                            ),
                                          ),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(_itemCount.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                                        ),
                                        ClipOval( child: Material( color: Color(0xFF303030), 
                                          child: InkWell( onTap: ()=>setState(()=>_itemCount++),
                                            child: Padding( padding: EdgeInsets.all(8.0), child: SizedBox( width: devHeight * 0.038, height: devHeight * 0.038,
                                              child: Icon(Icons.add_rounded, color: Colors.white70,),),
                                            ),
                                          ),),
                                        ),
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            //CATEGORIES/////////////////////////////////
                            if(itemCat != null) Row( children: [
                              for (var i = 0; i < itemCat.length; i++)
                              GestureDetector(
                                onTap: () {
                                  _selectedCategories = "${itemCat[i]}";
                                  setState(() {
                                    _selected = i;
                                    _foodRef.doc(widget.foodId).get().then((value) {
                                      setState(() {
                                        _selectedCategories = "${itemCat[i]}";
                                        itemCal = value.data()['calories'][_selected].toString();
                                        itemPrice =value.data()['sprice'][_selected].toString();
                                      });
                                    });
                                  });
                                },
                                child: Container(
                                  width: 95.0,
                                  height: 42.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _selected == i ? Color(0xFF00c569) : Color(0xFF707070),
                                      width: 2.0,
                                    ),
                                    color: _selected == i ? Color(0xFF00c569).withOpacity(0.5) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric( horizontal: 4.0, vertical: 12.0),
                                  child: Text( "${itemCat[i]}", style: TextStyle( fontWeight: FontWeight.w600, color: _selected == i ? Colors.white : Color(0xFF707070), fontSize: 16.0,),)
                                ),
                              )],
                            ),
                            //SELLERS////////////////////////////////////////
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.symmetric(vertical: 16), 
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF151515)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4.0),
                                        child: CachedNetworkImage(
                                          imageUrl: sellerImage,
                                          placeholder: (context, url) =>
                                            Image(image: AssetImage("assets/images/no_img.jpg"), fit: BoxFit.cover,),
                                          fadeOutDuration: const Duration(seconds: 1),
                                          fadeInDuration: const Duration(seconds: 1),
                                          fit: BoxFit.cover,
                                          ),
                                        //Image.network(sellerImage, fit: BoxFit.cover, height: 32,),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(itemSeller, style: TextStyle(color: Colors.white70, fontSize: 16),),
                                        Text("See Details", style: TextStyle(color: Colors.white54, fontSize: 12), ),
                                      ],
                                    ),
                                    Text("₹" + itemPrice, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //ADDONS/////////////////////////////////////
                            if(itemAdd[0] != null)  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(4, 8, 8, 4),
                                  child: Text("Choice of Add On:", style: TextStyle(fontSize: devWidth * 0.055, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                Column(
                                  children: [
                                    for(var j = 0; j < itemAdd.length; j++) Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${itemAdd[j]}", style: TextStyle(color: Colors.white70, fontSize: devWidth * 0.05 ),),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text("+ ₹" +"${itemAddPrice[j]}",  style: TextStyle(color: Colors.white70, fontSize: devWidth * 0.05 ),),
                                                SizedBox(width: devWidth * 0.05,),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _isChecked = !_isChecked;
                                                    });
                                                  },
                                                  child: AnimatedContainer(
                                                    duration: Duration(milliseconds: 500),
                                                    curve: Curves.fastLinearToSlowEaseIn,
                                                    decoration: BoxDecoration(
                                                      color: _isChecked ? Color(0xFF00c569) : Colors.transparent,
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      border: _isChecked ? null : Border.all(
                                                        color: Colors.grey,
                                                        width: 2.0,
                                                      )
                                                    ),
                                                    width: 23,
                                                    height: 23,
                                                    child: _isChecked ? Icon( Icons.check_rounded, color: Colors.white, size: 18,) : null,
                                                  ),
                                                )
                                              ],
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: devWidth * 0.12,
                              width: devWidth,
                              color: Colors.transparent,
                            )
                          ],
                        )
                      ),                                      
                    ],
                  ),
                )
              ],                  
            ),
            Positioned(
              top: devHeight * 0.315,
              right: 40,
              child: ScaleTransition(
                scale: _hideFabAnimation,
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF00c569),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  elevation: 8,
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image(image: AssetImage("assets/images/fav.png"),),
                  ),
                ),
              )
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: devHeight * 0.01, horizontal: 20),
                height: devWidth * 0.185,
                width: devWidth,
                color: Color(0xFF202020),
                //202020
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _addToCart();
                        setState(() {
                          _cartAdded = !_cartAdded;
                        });
                        Scaffold.of(context).showSnackBar(_snackBar);
                      },
                      child:Container(
                        padding: EdgeInsets.all(8),
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: _cartAdded ? Colors.orange[200].withOpacity(0.5) : Color(0xFF303030),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        alignment: Alignment.center,
                        child:  Icon(
                          _cartAdded ? Icons.shopping_cart_rounded : Icons.add_shopping_cart_rounded,
                          color: _cartAdded ? Colors.orangeAccent : Colors.white70, size: 36,
                          //Color(0xFF14d97d)
                        )
                      ),
                    ),
                    Expanded(
                      child: Bouncing(
                        onPress: () {},
                        child: Container(
                          height: 55.0,
                          margin: EdgeInsets.only(left: 16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF00c569),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(  "Quick Order",  style: TextStyle( color: Colors.white, fontSize: 20.0,  fontWeight: FontWeight.w600,),),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: InkWell(
                        onTap: (){Navigator.pop(context);},
                        child: Container(color: Colors.black.withOpacity(0.3), child: Padding(padding: EdgeInsets.all(12), child: Image(image: AssetImage("assets/icon/icon_light/arrow_back.png"), height: devHeight * 0.038,),))
                      ),
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}