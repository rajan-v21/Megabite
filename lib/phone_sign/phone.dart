import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:megabite/phone_sign/otp_verify.dart';

class Phone extends StatefulWidget {

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Container(
              height: 200,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          //offset: Offset(1.0, 0.0),
                          spreadRadius: 1.0
                        )
                      ],
                    ),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),  
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: TextStyle(color: Colors.black,),
                      initialValue: number,
                      textFieldController: _controller,
                      formatInput: false,
                      //spaceBetweenSelectorAndTextField,
                      keyboardType: TextInputType.phone,
                      //numberWithOptions(signed: true, decimal: true)
                      inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  Spacer(),
                  Container(
              //margin: EdgeInsets.all(8),
              width: double.infinity,
              child: FlatButton(
                color: Colors.blueAccent, 
                onPressed: () {
                  formKey.currentState.save();
                  Fluttertoast.showToast(
                    msg: "An OTP has been sent to your number!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    //timeInSecForIosWeb: 5,
                    backgroundColor: Color.fromRGBO(0, 205, 134, 1.0),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpVerify(_controller.text)));
                },
                child: Text("Send OTP", 
                  style: TextStyle(
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
    );
  }
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IN');

    setState(() {
      this.number = number;
    });
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}