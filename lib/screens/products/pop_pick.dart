import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megabite/screens/products/foodpage.dart';
import 'package:megabite/screens/products/fpage.dart';
import 'package:megabite/widget/product_card.dart';
import 'package:shimmer/shimmer.dart';

class PopPick extends StatefulWidget {
  @override
  _PopPickState createState() => _PopPickState();
}

class _PopPickState extends State<PopPick> {
  final CollectionReference _foodRef = FirebaseFirestore.instance.collection("Food");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _foodRef.get(),
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
                            Text( "Error!", style: TextStyle( fontSize: 28, color: Colors.redAccent,),)
                          ],
                        ),
                        Text( "${snapshot.error}", style: TextStyle( fontSize: 16,), ),
                      ],
                    )
                  );
                }
                if(snapshot.connectionState == ConnectionState.done){
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.docs.map((document){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPage(foodId: document.id)));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [BoxShadow(
                              color: Colors.grey[350], offset: Offset(0, 0), blurRadius: 3),]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Stack(
                              children: [ Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 92,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        imageUrl: "${document.data()['image']}",
                                        placeholder: (context, url) =>
                                          Image(image: AssetImage("assets/images/no_img.jpg"), fit: BoxFit.cover,),
                                        fadeOutDuration: const Duration(seconds: 1),
                                        fadeInDuration: const Duration(seconds: 1),
                                      ),
                                      /*FadeInImage.assetNetwork(
                                        placeholder: "assets/images/no_img.jpg", 
                                        fadeOutDuration: Duration(seconds: 2),
                                        image: "${document.data()['image']}"),*/
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                                    child: Text("${document.data()['name']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                                    child: Text("${document.data()['tag']}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14,),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric( horizontal: 2.0, vertical: 1.0),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(4, 2, 6, 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green[700],
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image(image: AssetImage("assets/images/stars.png"), height: 12,),
                                          Text(" ${document.data()['rate']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 5,
                                right: 8,
                                child: ClipOval(child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: InkWell(
                        onTap: (){},
                        child: Container(color: Colors.white.withOpacity(0.3), child: Padding(padding: EdgeInsets.all(4), child: Image(image: AssetImage("assets/images/fav.png"), height: 18,),))),),),)
                              ]
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                //loading state
                return Scaffold(
                  body: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [BoxShadow(
                              color: Colors.grey[350], offset: Offset(0, 0), blurRadius: 5),]
                          ),
                        child: Padding(padding: EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 92,
                              child: ShimmerPopPick.circular(height: 92, width: double.infinity, 
                                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 4, 2, 2),
                              child: ShimmerPopPick.rectangular(height: 18,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: ShimmerPopPick.rectangular(height: 18, width: 100,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                              child: ShimmerPopPick.rectangular(height: 14),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: ShimmerPopPick.rectangular(height: 16, width: 40,),
                            ),
                          ],
                        ),),
                      );
                    },
                  )
                );

            })
        ],
      ),      
    );
  }
}

class ShimmerPopPick extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerPopPick.rectangular({
    this.width = double.infinity,
    @required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerPopPick.circular({
    @required this.height,
    @required this.width,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[400],
    highlightColor: Colors.grey[300],
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400],
        shape: shapeBorder,
      ),
    ),
  );
}

/*
ListTile(
                        title: ShimmerPopPick.rectangular(height: 18),
                        subtitle: ShimmerPopPick.rectangular(height: 14),
                      )
 */
