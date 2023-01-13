import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/forgotPassword.dart';
import 'package:morsel_application_1/Pages/sellerHomePage.dart';
import 'package:morsel_application_1/Pages/signUpPage.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'package:morsel_application_1/Widgets/inputTextBox.dart';
import '../Widgets/theActionButton.dart';
import 'buyerHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'charityHomePage.dart';

Color _errorTextColor = Colors.white;

class signInPage extends StatefulWidget {
  signInPage({super.key});

  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  void initState() {
    customVariables.activeUser.clear();
    super.initState();
  }

  @override
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
              inputTextBox(
                hintText: "Email",
                obscureText: false,
                onTextChanged: (value) {
                  customVariables.activeUser.emailID =
                      value.toString().toLowerCase();
                },
              ),
              inputTextBox(
                  hintText: "Password",
                  obscureText: true,
                  onTextChanged: (value) {
                    customVariables.activeUser.password = value;
                  }),
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
              theActionButton(
                buttonText: "Sign in",
                onTap: () async {
                  await signInWithEmailAndPassword(
                      email: customVariables.activeUser.emailID.toString(),
                      password: customVariables.activeUser.password.toString());
                  setState(
                    () {
                      if (customVariables.activeUser.loginStatus == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          if (customVariables.activeUser.userType == "Buyer") {
                            return buyerHomePage();
                          } else if (customVariables.activeUser.userType ==
                              "Seller") {
                            return sellerHomePage();
                          } else if (customVariables.activeUser.userType ==
                              "Charity") {
                            return charityHomePage();
                          } else {
                            return signInPage();
                          }
                        }));
                      } else {
                        _errorTextColor = Colors.red;
                      }
                    },
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  if (customVariables.activeUser.emailID != null) {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: customVariables.activeUser.emailID!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotPassword()));
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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

signInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    final returnUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());
    if (returnUser != null) {
      customVariables.activeUser.loginStatus = true;
      _errorTextColor = Colors.white;
      var loggedUser = await FirebaseFirestore.instance
          .collection('user')
          .where('emailID', isEqualTo: customVariables.activeUser.emailID)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          customVariables.activeUser.userType = doc["Type"] ?? "Buyer";
          customVariables.activeUser.businessAddress =
              doc["businessAddress"] ?? "";
          customVariables.activeUser.businessName = doc["businessName"] ?? "";
        });
      }).catchError((error) => print("Failed to get user: $error"));
    }
  } catch (e) {
    customVariables.activeUser.loginStatus = false;
    _errorTextColor = Colors.red;
  }
}
