import 'package:flutter/material.dart';

class SortContent extends StatefulWidget {

  @override
  _SortContentState createState() => _SortContentState();
}

class _SortContentState extends State<SortContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container( margin: EdgeInsets.all(12), height: 8, width: 75, decoration: BoxDecoration( borderRadius: BorderRadius.circular(25),
                  color: Colors.grey,
                ),
              ),
      ],
    );
  }
}