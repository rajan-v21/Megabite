import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  
  @override
  _CustomInputState createState() => _CustomInputState();
  final String hintText;
  final String labelText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Function(String) validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final prefixIcon;
  final suffixIcon;
  final bool obscureText;
  final keyboardType;

  CustomInput(
      {this.hintText,
      this.labelText,
      this.focusNode,
      this.textInputAction,
      this.onChanged,
      this.onSubmitted,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.keyboardType});

}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onSaved: widget.onSubmitted,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
          hintText: widget.hintText ?? "HintText",
          labelText: widget.labelText ?? "LabelText",
          prefixIcon: widget.prefixIcon ?? null,
          suffixIcon: widget.suffixIcon ?? null,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        ),
        
      ),
    );
  }
}
