import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import '../Pages/buyerHomePage.dart';

class theActionButton extends StatefulWidget {
  theActionButton({super.key, required this.buttonText, this.onTap});
  String buttonText;
  Function? onTap;

  @override
  State<theActionButton> createState() => _theActionButtonState();
}

class _theActionButtonState extends State<theActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        widget.onTap!();
      }),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: customVariables.morselGreenColor,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
