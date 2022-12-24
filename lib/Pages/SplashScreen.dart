import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/colors.dart' as var_color;
import 'signInPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  "images/morsel_logo.png",
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => signInPage()),
            );
          },
          backgroundColor: var_color.morselGreenColor,
          child: Icon(
            Icons.arrow_right,
            size: 50,
          ),
        ));
  }
}
