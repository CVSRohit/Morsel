import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/signUpPage.dart';
import 'package:morsel_application_1/constants/colors.dart' as var_color;
import 'package:morsel_application_1/Widgets/inputTextBox.dart';

import '../Widgets/theActionButton.dart';
import 'homePage.dart';

class signInPage extends StatelessWidget {
  signInPage({super.key});

  @override
  Color _errorTextColor = Colors.red;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/morsel_logo.png",
                height: 300,
              ),
              inputTextBox(hintText: "Email"),
              inputTextBox(
                hintText: "Password",
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Incorrect Emailid or Password. Please check!",
                  style: TextStyle(
                    color: _errorTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              theActionButton(),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUpPage())),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Sign-up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
