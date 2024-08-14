import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:provider/provider.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text1, text2;
  final Image img;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text1,
      this.text2,
      this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius,
              right: Constants.padding,
              bottom: 16),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 0), blurRadius: 1),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 0.035 * devHeight,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(
                  fontSize: 0.025 * devHeight,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      /*gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0),
                          ]),*/
                      color: Color.fromRGBO(0, 209, 134, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                        child: Text(
                          widget.text1,
                          style: TextStyle(
                            fontSize: 0.028 * devHeight,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      width: 9,
                    ),
                    FlatButton(
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        child: Text(
                          widget.text2,
                          style: TextStyle(
                            fontSize: 0.028 * devHeight,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.zero),
                child: Image.asset("assets/images/alert.png")),
          ),
        ),
      ],
    );
  }
}