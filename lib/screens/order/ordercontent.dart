import 'package:flutter/material.dart';

class OrderContent extends StatefulWidget {

  @override
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Center(child: Text("Order Content"),)      
    );
  }
}