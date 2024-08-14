import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final leftimage;
  final Function lefttap;
  final Color leftcolor;
  final Image rightimage;
  final Function righttap;
  final Color rightcolor;
  final Color appbarcolor;
  final String text;
  
  

  const CustomAppBar({Key key,this.appbarcolor, this.leftimage, this.lefttap, this.leftcolor, this.rightimage, this.righttap, this.rightcolor, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: appbarcolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                color: leftcolor,
                child: InkWell(
                  onTap: lefttap,
                  //(){Scaffold.of(context).openDrawer();},
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: SizedBox(
                      width: devHeight * 0.038,
                      height: devHeight * 0.038,
                      child: leftimage,
                    ),
                  ),
                ),
              ),
            ),
            Text(text, style: TextStyle(fontSize: devWidth * 0.055, fontFamily: 'VarelaRound', fontWeight: FontWeight.w400,),),
            //ThemeButton(),
            Container(
              child: ClipOval( child: 
                    Material( color: rightcolor, 
                child: InkWell( onTap: righttap,
                      child: Padding( padding: const EdgeInsets.all(14.0), child: SizedBox( width: devHeight * 0.038, height: devHeight * 0.038,
                        child: rightimage,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
