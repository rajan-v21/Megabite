import 'package:flutter/material.dart';
import 'package:megabite/provider/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  DefaultButton({this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;

    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
                                  color: Color(0xff00c569),
                                  borderRadius: BorderRadius.circular(15),
                                ),
        /*child: OutlinedButton(style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff00C569)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: onPressed,*/
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: devHeight * 0.025),
                    child: Text(
                        text ?? "text",
                        style: TextStyle(
                            fontSize: 0.048 * devWidth,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'VarelaRound'),
                      ),
                  ),
                  
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Center(
                  child: SizedBox(
                    //height: 0.05 * devHeight,
                    //width: 0.05 * devHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: devWidth * 0.02),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Constants.kPrimaryColor),
                        ),
                      )
                      ),
                ),
              ),
            ],
          ),
        //),
    ));
  }
}
