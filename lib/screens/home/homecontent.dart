import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megabite/buttons/search_button.dart';
import 'package:megabite/buttons/z_animated_toggle.dart';
import 'package:megabite/offerbanner/offer_images.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/screens/products/pop_pick.dart';
import 'package:megabite/screens/products/pop_pick_all.dart';
import 'package:megabite/screens/products/foodpage.dart';
import 'package:megabite/screens/search/searchscreen.dart';
import 'package:megabite/buttons/action_text.dart';
import 'package:megabite/screens/sort_content.dart';
import 'package:megabite/widget/dashboard.dart';
import 'package:megabite/widget/product_card.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>{

  //AnimationController _animationController;
  //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller;
  CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  User _user = FirebaseAuth.instance.currentUser;
  String pincode = '';

  @override
  void initState() {
    //_animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    controller = TextEditingController();
    _userRef.doc(_user.uid).get().then((value) {
      setState(() {
        pincode = value.data()['pincode'].toString();
      });
    });
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  /*changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }*/

  Future<String> openPinDialog() => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Pincode"),
      content: TextField(
        autofocus: true,
        controller: controller,
        onSubmitted: (_) => submit(),
        decoration: InputDecoration(
          hintText: "Enter your pincode"
        ),
      ),
      actions: [
        TextButton(
          onPressed: submit, 
          child: Text("Submit"))
      ],
    ));

    void submit(){
      Navigator.of(context).pop(controller.text);
      controller.clear();
    }
  
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return 
        Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: Colors.black54,),
                    ActionText(
                    text: "Deliver to ", textcolor: Colors.black54, 
                    height: 0.025 * devHeight, weight: FontWeight.w400,
                    text2: pincode.isEmpty ? "Select Your Pincode" : pincode, text2color: Color(0xFF00c569), height2: 0.025 * devHeight, 
                    style2: TextDecoration.underline, weight2: FontWeight.w400,
                    onPressed: () async {
                      final pincode = await openPinDialog();
                      if (pincode == null || pincode.isEmpty)
                        return;
                      setState(() => this.pincode = pincode);
                      FirebaseFirestore.instance.collection("Users").doc(_user.uid).update({'pincode': pincode});
                    },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container( width: double.infinity, decoration: BoxDecoration( borderRadius: BorderRadius.circular(25), 
                  ),
                  child: Text("Let's order something \ndelicious!", style: TextStyle(fontSize: devHeight * 0.048, fontFamily: 'VarelaRound', fontWeight: FontWeight.w900,),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                      child: SearchButton(
                        width: .76 * devWidth,
                        buttonColor: Color(0xffefefef),
                        child: Text("Search Food or Restaurant",overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black54, 
                        fontSize: devHeight * 0.025, fontFamily: 'VarelaRound', fontWeight: FontWeight.w700,),),
                        image: Image(image: AssetImage("assets/icon/icon_basic/search.png"), color: Colors.black54, 
                        height: devHeight * 0.04,),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
                        },
                      ),
                    ),
                    Spacer(),
                    ClipOval(
                    child: Material(
                    color: Color(0xffffffff),
                    child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                                height: devHeight * 0.75,
                              decoration: new BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0),
                                ),
                              ),
                              child: SortContent(),
                            );
                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        width: devHeight * 0.038,
                        height: devHeight * 0.038,
                        child: Image(
                          image: AssetImage("assets/icon/icon_dark/sort.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OfferImg(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 6),
                child: Container( width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Popular Picks", style: TextStyle(fontSize: devHeight * 0.028, fontWeight: FontWeight.bold,),),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                      GestureDetector(child: Text("See All >>", style: TextStyle(fontSize: devHeight * 0.021, color: Color(0xFF00c569)),),
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PopPickAll()));
                    }),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 8.0),
                height: devWidth * 0.56,
                child: PopPick()
              ),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                child: Container( width: double.infinity, decoration: BoxDecoration( borderRadius: BorderRadius.circular(25), 
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Featured Restaurant", style: TextStyle(fontSize: devHeight * 0.028, fontFamily: 'VarelaRound', fontWeight: FontWeight.bold,),),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                      TextButton(
                    child: Text("View All >>", style: TextStyle(fontSize: devHeight * 0.021, fontFamily: 'VarelaRound', color: Color(0xFF00c569)),),
                    onPressed: null),
                    ],
                  ),
                ),
              ),
              //Column(RestaurantCard()),
              Container( margin: EdgeInsets.all(8), height: 200, width: 200, decoration: BoxDecoration( borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                ),
              ),
              Container( margin: EdgeInsets.all(8), height: 200, width: 200, decoration: BoxDecoration( borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                ),
              ),
              /*ZAnimatedToggle(
                values: ['Light', 'Dark'],
                onToggleCallback: (v) async {
                  await themeProvider.toggleThemeData();
                  setState(() {});
                  changeThemeMode(themeProvider.isLightTheme);
                },
              ),*/
            ],
    );
  }
}