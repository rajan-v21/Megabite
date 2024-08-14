import 'package:flutter/material.dart';
import 'package:megabite/phone_sign/phone_form.dart';
import 'package:megabite/provider/theme_provider.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
          child: Column(
            children: [
              CustomAppBar(
                appbarcolor: Color(0xffffffff),
                leftimage: Image(
                        image: AssetImage("assets/icon/icon_dark/arrow_back.png"),),
                lefttap: () {
                  Navigator.pop(context);
                },
                leftcolor: Color(0xffffffff),
                text: "Phone Auth",
                rightimage: Image.asset("assets/images/blank.png"),
                righttap: () {},
                rightcolor: Color(0xffffffff),
              ),
              Expanded(
                child: Container(
                  color: Color(0xffffffff),
                  width: double.infinity,
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: devHeight * 0.04,
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(
                            fontSize: devHeight * 0.055,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'VarelaRound'),
                      ),
                      Text(
                        "Authentication",
                        style: TextStyle(
                            fontSize: devHeight * 0.055,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'VarelaRound'),
                      ),
                      Text(
                        "Enter your Phone Number to Continue!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: devHeight * 0.025,
                        fontFamily: 'VarelaRound'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.055 * devWidth),
                        child: Container(
                          child: PhoneForm(),
                        ),
                      ),
                      SizedBox(
                        height: devHeight * 0.12,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        Text(
                          "By continuing, you confirm that you agree",
                          style: TextStyle(
                            fontSize: 0.020 * devHeight,
                            fontFamily: 'VarelaRound',
                          ),
                        ),
                        
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "with our ",
                            style: TextStyle(
                              fontSize: 0.020 * devHeight,
                              fontFamily: 'VarelaRound'
                            ),
                          ),
                          GestureDetector(
                          onTap: () {},
                          child: Text(
                            "T&C",
                            style: TextStyle(
                              color: Colors.blueAccent[700],
                              fontSize: 0.020 * devHeight,
                              decoration: TextDecoration.underline,
                              fontFamily: 'VarelaRound'
                            ),
                          ),
                        ),
                        Text(
                            " and ",
                            style: TextStyle(
                              fontSize: 0.020 * devHeight,
                              fontFamily: 'VarelaRound'
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Private Policy",
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 0.020 * devHeight,
                                decoration: TextDecoration.underline,
                                fontFamily: 'VarelaRound'
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                        height: devHeight * 0.02,
                      ),
                    ],
                  )
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