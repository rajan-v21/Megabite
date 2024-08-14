import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 120,
            aspectRatio: 640/360,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bannerimg1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //child: Text("Fashion"),
            ),
            Container(
              //margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bannerimg2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //child: Text("Fashion"),
            ),
            Container(
              //margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bannerimg3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //child: Text("Fashion"),
            ),
            Container(
              //margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bannerimg4.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //child: Text("Fashion"),
            ),
            Container(
              //margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bannerimg5.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //child: Text("Fashion"),
            ),
          ],
        )
    );
  }
}