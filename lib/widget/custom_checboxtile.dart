import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckBoxTile extends StatefulWidget {
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final String title;
  final String subtitle;

  const CheckBoxTile({
    Key key, 
    this.isChecked, 
    this.size, 
    this.iconSize, 
    this.selectedColor, 
    this.selectedIconColor, 
    this.title, 
    this.subtitle,
    }) : super(key: key);

  @override
  _CheckBoxTileState createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: TextStyle(color: Colors.white70, fontSize: devWidth * 0.05 ),),
          Container(
            child: Row(
              children: [
                Text(widget.subtitle,  style: TextStyle(color: Colors.white70, fontSize: devWidth * 0.05 ),),
                SizedBox(width: devWidth * 0.05,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    decoration: BoxDecoration(
                      color: _isSelected ? widget.selectedColor ?? Color(0xFF00c569) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: _isSelected ? null : Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      )
                    ),
                    width: widget.size ?? 23,
                    height: widget.size ?? 23,
                    child: _isSelected ? Icon(
                      Icons.check_rounded,
                      color: widget.selectedIconColor ?? Colors.white,
                      size: widget.iconSize ?? 18,
                    ) : null,
                  ),
                )
              ],
            )
          )
        ],
      ),
      
    );
  }
}