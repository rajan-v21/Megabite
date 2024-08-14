import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
    this.subline,
  }) : super(key: key);
  final String text, image, subline;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          text,
          style: TextStyle(
            fontSize: 0.05 * devHeight,
            color: Color(0xff00c569),
            fontWeight: FontWeight.bold,
            fontFamily: 'VarelaRound'
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            subline,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 0.025 * devHeight, fontFamily: 'VarelaRound'),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Container(
          child: Image.asset(
            image,
            height: 0.44 * devHeight,
          ),
        ),
      ],
    );
  }
}
