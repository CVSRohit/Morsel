import 'package:flutter/material.dart';

import '../Widgets/inputTextBox.dart';
import '../Widgets/theActionButton.dart';

class signUpPage extends StatelessWidget {
  const signUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color _errorTextColor = Colors.red;
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
              inputTextBox(
                hintText: "Repeat password",
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
