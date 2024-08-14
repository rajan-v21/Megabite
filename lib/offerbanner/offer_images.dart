import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megabite/offerbanner/image_swipe.dart';
import 'package:shimmer/shimmer.dart';

class OfferImg extends StatelessWidget {
  final CollectionReference _offerRef = FirebaseFirestore.instance.collection("Offers");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[200],),
      child: FutureBuilder(
            future: _offerRef.doc('oPrIvaXl4PnSCflTHXqc').get(),
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
                  Map<String, dynamic> documentData = snapshot.data.data();
                  List imageList = documentData['offerimg'];
                  return ImageSwipe(
                        imageList: imageList,
                      );
                }
                return Scaffold(
                  body: Container(
                    child: ShimmerOffer.circular(height: 150, width: double.infinity, 
                                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
                  )
                );
            })
    );
  }
}

class ShimmerOffer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerOffer.circular({
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