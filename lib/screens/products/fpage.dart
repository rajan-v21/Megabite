/* 
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FPage extends StatefulWidget {
  final String foodId;
  FPage({this.foodId});

  @override
  _FPageState createState() => _FPageState();
}

class _FPageState extends State<FPage> {
  final CollectionReference _foodRef = FirebaseFirestore.instance.collection("Food");
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: FutureBuilder(
            future: _foodRef.doc(widget.foodId).get(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.redAccent),
                            Text( "Error!", style: TextStyle( fontSize: 28, color: Colors.redAccent, fontFamily: 'VarelaRound'),)
                          ],
                        ),
                        Text( "${snapshot.error}", style: TextStyle( fontSize: 16, fontFamily: 'VarelaRound'), ),
                      ],
                    )
                  );
                }

                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> documentData = snapshot.data.data();
                  return Stack(
                    children: [
                      Image.network("${documentData['image']}") ?? Image(image: AssetImage("assets/images/no_img.jpg")),
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
                      child: Container(color: Colors.black.withOpacity(0.3), child: Padding(padding: EdgeInsets.all(12), child: Image(image: AssetImage("assets/icon/icon_light/arrow_back.png"), height: devHeight * 0.038,),))),),),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Spacer(),
                          Container(
                            height: devHeight * 0.7,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                      color: Color(0xFF202020),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    height: devHeight * 0.65,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: devWidth * 0.7,
                                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                          child: Text("${documentData['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white),
                                  ),
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
                                                      Text(" ${documentData['rate']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),),
                                                      Text("(6)", style: TextStyle(fontSize: 12.0, color: Colors.white),)
                                                    ],
                                                  )),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange),
                                                    child: Text("${documentData['calories'][0]} cals.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),)),
                                                ],
                                              ),
                                              Container(
                                                child: Row(children: <Widget>[
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
                                                        child: Icon(Icons.add_rounded, color: Colors.white70,),
                                                        ),
                                                      ),
                                                    ),),
                                                  ),
                                                ],)
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 2.0),
                                          child: Text("Choice of Add On:", style: TextStyle(fontSize: devHeight * 0.028, fontWeight: FontWeight.bold, color: Colors.white),),
                                        )
                                      ],
                                    )
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 40,
                                  child: Container(
                                  height: devWidth * 0.15,
                                  width: devWidth * 0.15,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF14d97d),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [BoxShadow(
                              color: Colors.grey, offset: Offset(1, 1), blurRadius: 3),]
                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Image(image: AssetImage("assets/images/fav.png"),),
                                  ),),
                                ))
                              ]
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }

                //loading state
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00c569)),
                    ),
                  )
                );
            },
          )      
    );
  }
}
 */