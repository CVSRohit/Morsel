import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/colors.dart' as var_color;
import '../Pages/homePage.dart';

class theActionButton extends StatelessWidget {
  const theActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const homePage(),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: var_color.morselGreenColor,
        ),
        child: Text(
          "Sign in",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
