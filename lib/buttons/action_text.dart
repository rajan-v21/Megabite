import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  
  final String text;
  final double height;
  //final String font;
  final FontWeight weight;
  final TextDecoration style;
  final Color textcolor;
  final String text2;
  final double height2;
  //final String font2;
  final FontWeight weight2;
  final TextDecoration style2;
  final Color text2color;
  final Function onPressed;

  const ActionText(
      {Key key,
      this.text,
      this.style,
      this.textcolor,
      //this.font,
      this.weight,
      this.height,
      this.text2,
      this.style2,
      this.text2color,
      //this.font2,
      this.weight2,
      this.height2,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: height, fontFamily: 'VarelaRound',
              fontWeight: weight,
              color: textcolor,
              decoration: style, ),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            text2.length > 20 ? text2.substring(0, 20) : text2,
            //text2.length > 20 ? text2.substring(0, 20)+'...' : text2,
            style: TextStyle(
              fontSize: height2,
              fontFamily: 'VarelaRound',
              fontWeight: weight2,
              color: text2color,
              decoration: style2,
            ),
          ),
        ),
      ],
    );
  }
}
