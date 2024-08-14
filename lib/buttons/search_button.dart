import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  
  final Function onPressed;
  final double width;
  final Widget child;
  final Image image;
  final Color buttonColor;

  const SearchButton({
    Key key,
    this.onPressed,
    this.width,
    this.image,
    this.buttonColor,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(color: buttonColor,
      borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: 
              InkWell(
                  onTap: onPressed,
                  child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: image,
              ),
              Flexible(
                  child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}