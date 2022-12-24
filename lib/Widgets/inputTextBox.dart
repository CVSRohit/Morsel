import 'package:flutter/material.dart';

class inputTextBox extends StatelessWidget {
  inputTextBox({
    super.key,
    required this.hintText,
  });

  String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 300,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.all(20)),
      ),
    );
  }
}
