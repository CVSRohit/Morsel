import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/buyerHomePage.dart';
import 'package:morsel_application_1/Pages/charityHomePage.dart';
import 'package:morsel_application_1/Pages/sellerHomePage.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'signInPage.dart';
import 'dart:async';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  customVariables.activeUser.loginStatus == true
                      ? customVariables.activeUser.userType == "Seller"
                          ? sellerHomePage()
                          : customVariables.activeUser.userType == "Charity"
                              ? charityHomePage()
                              : buyerHomePage()
                      : signInPage()));
    });
  }

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
    );
  }
}
