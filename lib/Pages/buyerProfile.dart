import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/buyerOrdersPage.dart';
import 'package:morsel_application_1/Pages/signInPage.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'buyerHomePage.dart';

class buyerProfilePage extends StatelessWidget {
  const buyerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                                  "1.2 Kgs",
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
                                    "4.5 Kms",
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
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   // margin: EdgeInsets.only(right: 10),
                        //   padding: EdgeInsets.all(25),
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade300,
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         "Donated",
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 21),
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(
                        //             Icons.attach_money,
                        //             color: Colors.black,
                        //             size: 40,
                        //           ),
                        //           SizedBox(width: 10),
                        //           Text(
                        //             "55\$",
                        //             style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.all(10),
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
                                    "16\$",
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
                          margin: EdgeInsets.only(right: 0, top: 10),
                          padding: EdgeInsets.all(12),
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
                                  "x 3",
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
                  margin: EdgeInsets.only(left: 12, right: 12, top: 8),
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
                        Icons.medication,
                        size: 50,
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            "Karma Points",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          Text(
                            "14",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 8),
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
                        size: 40,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Help",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => buyerOrderPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 8),
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
                          Icons.sell,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "My Orders",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => signInPage())));
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
                    MaterialPageRoute(builder: (context) => buyerHomePage())),
                child: Column(children: [
                  Icon(Icons.map_outlined, size: 35),
                  Text("Map")
                ])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => buyerHomePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.search, size: 35), Text("Explore")])),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => buyerProfilePage())),
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
