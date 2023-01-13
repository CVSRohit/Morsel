import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/signInPage.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'charityHomePage.dart';

class charityProfilePage extends StatefulWidget {
  const charityProfilePage({super.key});

  @override
  State<charityProfilePage> createState() => _charityProfilePageState();
}

class _charityProfilePageState extends State<charityProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: customVariables.morselGreenColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "CO2e saved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            Row(children: [
                              Icon(
                                Icons.cloud,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "104 Kgs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ]),
                            Row(
                              children: [
                                Icon(
                                  Icons.drive_eta,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "32 Kms",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Money Saved",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.savings,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "55\$",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(25),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Donated",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "55\$",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: [
                          Text(
                            "Meals Saved",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 21),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.fastfood_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "55\$",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ]),
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 20),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          "Karma Points",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Text(
                          "75",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.help,
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Help",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "My Orders",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => signInPage())));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.green.shade900,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Log out",
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //------------------------Bottom navigation bar------------------------
      bottomNavigationBar: Container(
        height: 80,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => charityHomePage())),
                child: Column(children: [
                  Icon(Icons.map_outlined, size: 35),
                  Text("Map")
                ])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => charityHomePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 35),
                      Text("Donations")
                    ])),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => charityProfilePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                          size: 35, color: Colors.green.shade900),
                      Text("Profile",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold))
                    ])),
          ],
        ),
      ),
    );
  }
}
