import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megabite/screens/products/foodpage.dart';
import 'package:megabite/screens/products/fpage.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class PopPickAll extends StatelessWidget {
  final CollectionReference _foodRef = FirebaseFirestore.instance.collection("Food");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: SafeArea(
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
                  text: "Popular Picks",
                  rightimage: Image.asset("assets/images/blank.png"),
                  righttap: () {},
                  rightcolor: Color(0xffffffff),
                ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                color: Colors.white,
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
                                      Text( "Error!", style: TextStyle( fontSize: 28, color: Colors.redAccent, fontFamily: 'VarelaRound'),)
                                    ],
                                  ),
                                  Text( "${snapshot.error}", style: TextStyle( fontSize: 16, fontFamily: 'VarelaRound'), ),
                                ],
                              )
                            );
                          }
                          if(snapshot.connectionState == ConnectionState.done){
                            return Scrollbar(
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                childAspectRatio: (150 / 185),
                                children: snapshot.data.docs.map((document){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPage(foodId: document.id,)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                                      //height: 250,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12.0),
                                        boxShadow: [BoxShadow(
                                          color: Colors.grey[350], offset: Offset(0, 0), blurRadius: 3),]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 100,
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
                                              child: Text("${document.data()['name']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'VarelaRound'),),
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
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          //loading state
                          return Scaffold(
                            body: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: (150 / 185),
                              children: List.generate(50,(index){
                                return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    //height: 250,
    width: 150,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [BoxShadow(
        color: Colors.grey[350], offset: Offset(0, 0), blurRadius: 5),]
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: ShimmerPopPickAll.circular(height: 92, width: double.infinity, 
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 4, 2, 2),
              child: ShimmerPopPickAll.rectangular(height: 18,),),
            Padding(
              padding: const EdgeInsets.all(2),
              child: ShimmerPopPickAll.rectangular(height: 18,width: 100,),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              child: ShimmerPopPickAll.rectangular(height: 14,),),
            Padding(
              padding: const EdgeInsets.all(2),
              child: ShimmerPopPickAll.rectangular(height: 16,width: 40,),),
          ])));
                              }),),
                          );
                      })
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

_shimmerContent(){
  Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    //height: 250,
    width: 150,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [BoxShadow(
        color: Colors.grey[350], offset: Offset(0, 0), blurRadius: 5),]
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: ShimmerPopPickAll.circular(height: 92, width: double.infinity, 
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              child: ShimmerPopPickAll.rectangular(height: 18,),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              child: ShimmerPopPickAll.rectangular(height: 14,),),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 2.0, vertical: 1.0),
              child: ShimmerPopPickAll.rectangular(height: 16,),),
          ])));
}

class ShimmerPopPickAll extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerPopPickAll.rectangular({
    this.width = double.infinity,
    @required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerPopPickAll.circular({
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