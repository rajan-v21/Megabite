import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/cart/cartpage.dart';
import 'package:megabite/screens/home/homebackground.dart';
import 'package:megabite/screens/home/homecontent.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:megabite/widget/custom_alert.dart';
import 'package:megabite/widget/custom_bottombar.dart';
import 'package:megabite/widget/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  //final String name;
  //HomePage(this.name);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  //Animation hideOnRotationAnimation;
  Animation rotationAnimation;
  AnimationController _hideBarAnimation;
  AnimationController _hideFabAnimation;
  //bool isVisible = true;
  bool isFabCircle = true;
  final _advancedDrawerController = AdvancedDrawerController();
  double shrinkOffset;
  bool overlapsContent;
  int itemCount = 0;

  CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  User _user = FirebaseAuth.instance.currentUser;
  String userfName = '';
  String userlName = '';

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    _hideBarAnimation.dispose();
    _hideFabAnimation.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    /*hideOnRotationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);*/

    _hideBarAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();

    rotationAnimation = Tween<double>(begin: 45.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    _userRef.doc(_user.uid).get().then((value) {
      setState(() {
        userfName = value.data()['userfname'];
        userlName = value.data()['userlname'];
      });
    });
    /*_userRef.doc(_user.uid).collection("Cart").get().then((value){
    });*/
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
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
              _hideBarAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
              _hideBarAnimation.reverse();
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
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');
    
    User _user = FirebaseAuth.instance.currentUser;
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      //442274 
      //? Color(0xff0788ff)
      //: Color(0xff2a0a5b),
      //1e0036 dark violet blue
      //5518ab dark purple
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white12,
            offset: Offset(-12, 0),
            blurRadius: 1.0,
            spreadRadius: -6,
          ),
          BoxShadow(
            color: Colors.white10,
            offset: Offset(-24, 0),
            blurRadius: 1.0,
            spreadRadius: -12,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: WillPopScope(
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: Scaffold(
              key: _scaffoldKey,
              //drawer: CustomDrawer(),
              floatingActionButton: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value)),
                alignment: Alignment.center,
                child: ScaleTransition(
                  scale: _hideFabAnimation,
                  alignment: Alignment.center,
                  //child: Transform.rotate( angle: -math.pi / 4,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFF00c569),
                      shape: isFabCircle
                          ? RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))
                          : null,
                      elevation: 8,
                      onPressed: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                        setState(() {
                          isFabCircle = !isFabCircle;
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  //),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children:[ CustomAppBar(
                        appbarcolor: Color(0xffffffff),
                        leftimage: ValueListenableBuilder<AdvancedDrawerValue>(
                          valueListenable: _advancedDrawerController,
                          builder: (_, value, __) {
                            return AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: Image(
                                image:
                                value.visible ? 
                                AssetImage("assets/icon/icon_dark/clear.png")
                                : AssetImage("assets/icon/icon_dark/menu.png"),
                                key: ValueKey<bool>(value.visible),
                              ),
                            );
                          },
                        ),
                        lefttap: _handleMenuButtonPressed,
                        /*() {
                          _scaffoldKey.currentState.openDrawer();
                        },*/
                        leftcolor: Color(0xffffffff),
                        text: "Hi "+ userfName ?? "User",
                        rightimage: Image(
                          image: AssetImage("assets/icon/icon_dark/cart.png"),
                        ),
                        righttap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                        },
                        rightcolor: Color(0xffffffff),
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: SafeArea(
                            child: Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey[200],
                                  width: 2
                                )
                              ),
                              child: StreamBuilder(
                                stream: _userRef.doc(_user.uid).collection("Cart").snapshots(),
                                builder: (context, snapshot){
                                  if (snapshot.connectionState == ConnectionState.active){
                                    List _documents = snapshot.data.docs;
                                    itemCount = _documents.length;
                                  }
                                  return Text("$itemCount", style: TextStyle(color: Colors.white));
                                },
                              )
                            ),
                          ),
                        ),
                    
                      ]
                    ),
                    Expanded(
                      child: Stack(children: [
                        Container(
                          color: Color(0xffffffff),
                          width: double.infinity,
                          child: SingleChildScrollView(
                                child: HomeContent(),
                              ),
                        ),
                        Positioned(
                          bottom: 19,
                          right: 25,
                          left: 25,
                          child: ScaleTransition(
                              scale: _hideFabAnimation,
                              alignment: Alignment.center,
                              child: CustomBottomBar(),
                              /*Transform(
                                  transform: Matrix4.rotationZ(0)
                                    ..scale(hideOnRotationAnimation.value),
                                  alignment: Alignment.center,
                                  child: CustomBottomBar()),*/
                            ),
                          ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onWillPop: () {
            return showDialog(
                barrierColor: Colors.black54.withOpacity(0.3),
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: CustomDialogBox(
                      title: "Confirm Exit!",
                      descriptions: "Are you sure you want to exit?",
                      text1: "Yes",
                      text2: "Cancel",
                    ),
                  );
                });
          }),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 56.0,
                        height: 56.0,
                        margin: const EdgeInsets.only(
                          top: 64.0,
                          bottom: 64.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/profilepic.png',
                        ),
                      ),
                      Container(
                        height: 56,
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "Hi " + userfName + userlName ?? "User",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 0.05 * devWidth,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: devWidth * 0.52,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text( "megabiteuser123@gmail.com",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 0.035 * devWidth,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                ListTile(
                  onTap: () {},
                  leading: Image( image: 
                        AssetImage("assets/icon/icon_light/bag.png"),
                        height: 0.07 * devWidth,
                      ),
                  title: Text('Purchases'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image( image: 
                        AssetImage("assets/icon/icon_light/money.png"), 
                        height: 0.07 * devWidth,
                      ),
                  title: Text('Coins'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image( image: 
                        AssetImage("assets/icon/icon_light/settings.png"), 
                        height: 0.07 * devWidth,
                      ),
                  title: Text('Settings'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image( image: 
                        AssetImage("assets/icon/icon_light/share.png"), 
                        height: 0.07 * devWidth,
                      ),
                  title: Text('Share'),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 0.024 * devHeight,
                  ),
                  child: TextButton(
                    child: Text(
                      'Terms of Service | Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
