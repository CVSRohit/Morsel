import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

class inputTextBox extends StatefulWidget {
  inputTextBox(
      {super.key,
      required this.hintText,
      required this.onTextChanged,
      required this.obscureText});

  String hintText;
  Function onTextChanged;
  bool obscureText = false;

  @override
  State<inputTextBox> createState() => _inputTextBoxState();
}

class _inputTextBoxState extends State<inputTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 300,
      child: TextField(
        obscureText: widget.obscureText,
        onChanged: (value) {
          if (widget.onTextChanged != null) {
            widget.onTextChanged(value);
          }
        },
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.all(20)),
      ),
    );
  }
}
