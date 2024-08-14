import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  ImageSwipe({this.imageList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child:Stack(
              children: [
                PageView(
                  onPageChanged: (num) {
                    setState(() {
                      _selectedPage = num;
                    });
                  },
                  children: [
                    for (var i = 0; i < widget.imageList.length; i++)
                      CachedNetworkImage(
                        imageUrl: "${widget.imageList[i]}",
                        placeholder: (context, url) =>
                        Image(image: AssetImage("assets/images/no_img.jpg"), fit: BoxFit.cover,),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 1),
                        fit: BoxFit.cover,
                      ),
                      /*Image.network(
                          "${widget.imageList[i]}",
                          fit: BoxFit.cover,
                        ),*/
                  ],
                ),
                Positioned(
                  bottom: 15.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < widget.imageList.length; i++)
                        AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            width: _selectedPage == i ? 8.0 : 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: _selectedPage == i
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ))
                    ],
                  ),
                )
              ],
            )
    );
  }
}
