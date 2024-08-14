import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartContent extends StatefulWidget {
  @override
  _CartContentState createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> {
  final key = GlobalKey<AnimatedListState>();
  int itemCount = 0;
  List itemAdd;
  List itemAddPrice;
  int _totalPrice = 0;
  int _itemTAddPrice = 0;
  String itemPrice = '';
  int _itemCount = 1;
  int _preprice;

  CollectionReference _userRef = FirebaseFirestore.instance.collection('Users');
  User _user = FirebaseAuth.instance.currentUser;

  //CollectionReference _cartRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).collection("Cart");
  //FirebaseServices _firebaseServices =FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream:
                        _userRef.doc(_user.uid).collection("Cart").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        //List _documents = snapshot.data.docs;
                        itemCount = snapshot.data.docs.length;
                      }
                      return Text(
                          (itemCount != 0)
                              ? "$itemCount" + " items"
                              : "0" + " items",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF00c569)));
                    },
                  ),
                  Text(" in your food cart", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            StreamBuilder(
              stream: _userRef.doc(_user.uid).collection("Cart").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return AnimatedList(
                  key: key,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  initialItemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index, animation) => 
                    _buildListItem(context, snapshot.data.docs[index], animation, index),
                );
              },
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot document, Animation animation, int index){
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    int _quantity =
                        document.data()['quantity'];
                    int _quantityCount = _quantity;
    return SizeTransition(
                      sizeFactor: animation,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: IconSlideAction(
                                  caption: 'Save',
                                  color: Colors.blue,
                                  icon: Icons.favorite_outline_rounded,
                                  onTap: () {},
                                ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete_outline_rounded,
                                  onTap: () {
                                    _removeItem(index, document);
                                    //FirebaseFirestore.instance.collection('Users').doc(_user.uid).collection("Cart").doc(document.id).delete();
                                  },
                                ),
                            ),
                          ],
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              //margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[100],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(8),
                                      height: 90,
                                      width: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: CachedNetworkImage(
                                          imageUrl: document.data()['image'],
                                          placeholder: (context, url) => Image(
                                            image: AssetImage( "assets/images/no_img.jpg"),
                                            fit: BoxFit.fill,
                                          ),
                                          fadeOutDuration: const Duration(seconds: 1),
                                          fadeInDuration: const Duration(seconds: 1),
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                                          child: Text( document.data()['name'], overflow: TextOverflow.ellipsis, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 135,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding( padding: EdgeInsets.symmetric( vertical: 2.0),
                                                    child: Text( "₹ " + document.data()['totalprice'].toString(), style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF00c569)),),
                                                  ),
                                                  if (document.data()['categories'] != null)
                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Text( "Category: " + document.data()['categories'].toString(), style: TextStyle(fontSize: 14),)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  ClipOval(
                                                    child: Material(
                                                      color: Color(0xFF303030),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (_quantity > 1) {
                                                            setState(() {
                                                              _quantityCount--;
                                                              _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'quantity':_quantityCount});
                                                              _totalPrice = document.data()['totalprice'] - document.data()['netprice'];
                                                              _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'totalprice':_totalPrice});
                                                            });
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.all(4.0),
                                                          child: SizedBox(
                                                            width: devHeight * 0.038,
                                                            height: devHeight * 0.038,
                                                            child: Icon( Icons.remove_rounded, color: Colors.white70,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric( horizontal: 4.0),
                                                    child: Text( "$_quantity", style: TextStyle( fontSize: 16,),), //_itemCount.toString()
                                                  ),
                                                  ClipOval(
                                                    child: Material(
                                                      color: Color(0xFF303030),
                                                      child: InkWell(
                                                        onTap: () =>
                                                          setState(() {
                                                            _quantityCount++;
                                                            _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'quantity':_quantityCount});
                                                              _totalPrice = document.data()['totalprice'] + document.data()['netprice'];
                                                            _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'totalprice':_totalPrice});
                                                        }),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(4.0),
                                                          child: SizedBox(
                                                            width: devHeight * 0.038,
                                                            height: devHeight * 0.038,
                                                            child: Icon( Icons.add_rounded,
                                                              color: Colors.white70,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (document.data()['addon'] != null)
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    for (var i = 0; i < document.data()['addon'].length; i++)
                                                      if (document.data()['addon'][i] != null)
                                                        Container(
                                                          margin: EdgeInsets.only( right: 4),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.grey[350]),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.fromLTRB(4,2,4,2),
                                                                child: Text(
                                                                  document.data()['addon'][i],
                                                                  style: TextStyle(
                                                                      fontSize: 13),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.fromLTRB(4,2,4,2),
                                                                child: ClipOval(
                                                                  child: Material(
                                                                    color: Colors.red,
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        //delete field
                                                                        //FirebaseFirestore.instance.collection('Users').doc(_user.uid).collection("Cart").doc(snapshot.data.docs[index].id).update({'addon': FieldValue.delete()});
                                                                        //delete element of a field
                                                                        _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'addon': FieldValue.arrayRemove([document.data()['addon'][i]])});
                                                                        _totalPrice = document.data()['totalprice'] - (document.data()['addprice'][i] * _quantityCount);
                                                                        _userRef.doc(_user.uid).collection("Cart").doc(document.id).update({'totalprice':_totalPrice});
                                                                      },
                                                                      child: Icon(
                                                                        Icons.clear_rounded,
                                                                        color: Colors.white,
                                                                        size: 14,
                                                                      ),
                                                                    ),
                                                                  )))
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                              ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
  }
  void _removeItem(int i, DocumentSnapshot doc){
    FirebaseFirestore.instance.collection('Users').doc(_user.uid).collection("Cart").doc(doc.id).delete();
    DocumentSnapshot removedItem = doc;
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildListItem(context, removedItem, animation, i);
    };
    key.currentState.removeItem(i, builder);
  }
}
/*

 */