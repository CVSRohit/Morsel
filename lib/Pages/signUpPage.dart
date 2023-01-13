import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/buyerHomePage.dart';
import 'package:morsel_application_1/Pages/charityHomePage.dart';
import 'package:morsel_application_1/Pages/sellerHomePage.dart';
import 'package:morsel_application_1/Pages/signInPage.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import '../Widgets/inputTextBox.dart';
import '../Widgets/theActionButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

// enum userCategory { Buyer, Seller, Charity }

var userCategories = ["Buyer", "Seller", "Charity"];
String _userCategories = "Buyer";
bool unhideInputs = false;
Color _errorTextColor = Colors.white;

// userCategory? _userCategory = userCategory.Buyer;

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  void initState() {
    customVariables.activeUser.clear();
    super.initState();
  }

  @override
  bool passwordCheck = false;
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
                height: unhideInputs ? 200 : 300,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Radio(
                    activeColor: customVariables.morselGreenColor,
                    value: "Buyer",
                    groupValue: _userCategories,
                    onChanged: (value) {
                      setState(() {
                        _userCategories = value.toString();
                        unhideInputs = false;
                      });
                    }),
                Text("Buyer"),
                Radio(
                    activeColor: customVariables.morselGreenColor,
                    value: "Seller",
                    groupValue: _userCategories,
                    onChanged: (value) {
                      setState(() {
                        _userCategories = value.toString();
                        unhideInputs = true;
                      });
                    }),
                Text("Seller"),
                Radio(
                    activeColor: customVariables.morselGreenColor,
                    value: "Charity",
                    groupValue: _userCategories,
                    onChanged: (value) {
                      setState(() {
                        _userCategories = value.toString();
                        unhideInputs = false;
                      });
                    }),
                Text("Charity"),
              ]),
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
                  customVariables.activeUser.password = value.toString();
                },
              ),
              inputTextBox(
                hintText: "Repeat password",
                obscureText: true,
                onTextChanged: (value) {
                  setState(() {
                    if (value.toString() ==
                        customVariables.activeUser.password) {
                      _errorTextColor = Colors.white;
                      passwordCheck = true;
                    } else {
                      _errorTextColor = Colors.red;
                    }
                  });
                },
              ),
              unhideInputs
                  ? inputTextBox(
                      hintText: "Business Name",
                      obscureText: false,
                      onTextChanged: (value) {
                        setState(() {
                          customVariables.activeUser.businessName =
                              value.toString();
                        });
                      },
                    )
                  : Text(""),
              unhideInputs
                  ? inputTextBox(
                      hintText: "Business Address",
                      obscureText: false,
                      onTextChanged: (value) {
                        setState(() {
                          customVariables.activeUser.businessAddress =
                              value.toString();
                        });
                      },
                    )
                  : Text(""),
              theActionButton(
                buttonText: "Sign up",
                onTap: () async {
                  if (passwordCheck == true &&
                      ((_userCategories == "Seller" &&
                              customVariables.activeUser.businessName != null &&
                              customVariables.activeUser.businessAddress !=
                                  null) ||
                          _userCategories != "Seller")) {
                    await signUpWithEmailAndPassword(
                        email: customVariables.activeUser.emailID.toString(),
                        password:
                            customVariables.activeUser.password.toString());
                    setState(() {
                      if (customVariables.activeUser.loginStatus == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          if (_userCategories == "Buyer") {
                            return buyerHomePage();
                          } else if (_userCategories == "Seller") {
                            return sellerHomePage();
                          } else if (_userCategories == "Charity") {
                            return charityHomePage();
                          } else {
                            return signUpPage();
                          }
                        }));
                      } else {
                        _errorTextColor = Colors.red;
                      }
                    });
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "Incomplete or Incorrect information",
                  style: TextStyle(
                    color: _errorTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
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
                      "Sign-in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

signUpWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    final newUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (newUser != null) {
      customVariables.activeUser.loginStatus = true;
    }
    customVariables.activeUser.userType = _userCategories.toString();
    await addUserToFirestore();
  } catch (e) {
    _errorTextColor = Colors.red;
  }
}

addUserToFirestore() async {
  try {
    final db = await FirebaseFirestore.instance;
    final user = <String, String>{
      "Address": "",
      "Type": customVariables.activeUser.userType.toString(),
      "emailID": customVariables.activeUser.emailID.toString(),
      "userID": customVariables.activeUser.userID.toString(),
      "businessName": customVariables.activeUser.businessName.toString(),
      "businessAddress": customVariables.activeUser.businessAddress.toString(),
    };
    db
        .collection("user")
        .doc(customVariables.activeUser.userID.toString())
        .set(user);
  } catch (e) {
    print(e);
  }
}
