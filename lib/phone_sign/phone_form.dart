import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:megabite/buttons/bounce_button.dart';
import 'package:megabite/buttons/default_button.dart';
import 'package:megabite/phone_sign/otp_verify.dart';
import 'package:megabite/provider/constants.dart';
import 'package:megabite/provider/themeprovider.dart';
import 'package:megabite/widget/custom_input.dart';
import 'package:provider/provider.dart';

class PhoneForm extends StatefulWidget {

  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  final List<String> errors = [];
  String userName = "";

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    double devHeight = size.height;
    double devWidth = size.width;
    return Form(
        key: formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: devHeight * 0.025,
            ),
            //Name TextField
            CustomInput(
              hintText: "Enter your name",
              labelText: "Name",
              keyboardType: TextInputType.name,
              onChanged: (value) {
                userName = value;
                if (value.isNotEmpty) {
                  removeError(error: Constants.kNamelNullError);
                }
                return null;
              },
              validator: (value) {
                if (value.isEmpty) {
                  addError(error: Constants.kNamelNullError);
                  return Constants.kNamelNullError;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            //.........................
            SizedBox(
              height: devHeight * 0.04,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey),
                      borderRadius: new BorderRadius.all(Radius.circular(20.0)),
                      shape: BoxShape.rectangle,
                      color: Color(0xffffffff),
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
                      ///........... need change
                      selectorTextStyle: TextStyle(color: Colors.black,),
                      initialValue: number,
                      textFieldController: _controller,
                      formatInput: false,
                      //spaceBetweenSelectorAndTextField,
                      keyboardType: TextInputType.phone,
                      //numberWithOptions(signed: true, decimal: true)
                      inputBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  //Spacer(),
                  SizedBox(
              height: devHeight * 0.04,
            ),
                  Container(
              width: double.infinity,
              child: Bouncing(
                onPress: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    // if all are valid then go to success screen
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
                  }
                },
                child: DefaultButton( text: "Continue",),
              ),
            ),
                ],
              ),
            ),
                 
          ],
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