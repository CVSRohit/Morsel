import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/signInPage.dart';
import 'package:morsel_application_1/Widgets/theActionButton.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'package:morsel_application_1/main.dart';

class forgotPassword extends StatelessWidget {
  const forgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customVariables.morselGreenColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please check your email inbox and spam folders for password reset email",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              theActionButton(
                buttonText: "Back to sign in",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signInPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
